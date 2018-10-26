//
//  LocalStorageRepositoryImp.swift
//  Todo
//
//  Created by Fatih Şen on 26.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift
import MVICocoa

class LocalStorageRepositoryImp: LocalStorageRepository {
  
  private let kFileStorage = "storage.json"
  private let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

  private let disposeBag = DisposeBag()
  private let cache: Variable<[Todo]>
  
  private var url: URL {
    get {
      if let file = directory?.appendingPathComponent(kFileStorage) {
        return file
      }
      fatalError("you can not create such file in here")
    }
  }
  
  init(cache: Variable<[Todo]>) {
    // cache will be uploaded
    self.cache = cache
    // will sync the data with others
    disposeBag += cache.asObservable()
      .concatMap(persist(object: ))
      .subscribeOn(MainScheduler.asyncInstance)
      .subscribe()
  }
  
  func load() -> Observable<[Todo]> {
    return read(url: url, as: [Todo].self)
      .do(onNext: bind(_ :))
  }
  
  private func read<T>(url: URL, as type: T.Type) -> Observable<T> where T: Decodable, T: Encodable {
    return Observable.create { emitter in
      do {
        let decoder = JSONDecoder()
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: url.path) {
          if let data = fileManager.contents(atPath: url.path) {
            let result = try decoder.decode(type, from: data)
            emitter.onNext(result)
            emitter.onCompleted()
          }
        } else {
          let error = NSError(domain: "no such file \(url.path)", code: 401, userInfo: nil)
          emitter.onError(error)
        }
      } catch {
        emitter.onError(error)
      }
      
      return Disposables.create()
    }
  }
  
  private func write<T>(url: URL, object: T) -> Completable where T : Decodable, T : Encodable {
    return Completable.create { emitter in
      do {
        let encoder = JSONEncoder()
        let fileManager = FileManager.default
        
        let data = try encoder.encode(object)
        if fileManager.fileExists(atPath: url.path) {
          try fileManager.removeItem(at: url)
        }
        let success = fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
        if success {
          emitter(.completed)
        } else {
          let error = NSError(domain: "you could not create file at \(url.path)", code: 404, userInfo: nil)
          emitter(.error(error))
        }
      } catch {
        emitter(.error(error))
      }
      return Disposables.create()
    }
  }
  
  private func persist<T>(object: T) -> Observable<T> where T: Decodable, T: Encodable {
    return write(url: url, object: object)
      .andThen(Observable.of(object))
  }
  
  private func bind(_ value: [Todo]) {
    cache.value = value
  }
}
