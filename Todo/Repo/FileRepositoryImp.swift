//
//  FileRepositoryImp.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

class FileRepositoryImp: FileRepository {
	
	private let kFileStorage = "storage.json"
	private let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
	
	public var url: URL {
		get {
			if let file = directory?.appendingPathComponent(kFileStorage) {
				return file
			}
			fatalError("you can not create such file in here")
		}
	}
	
	func read<T>(_ url: URL, _ type: T.Type) -> Observable<T> where T : Decodable {
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
	
	func write<T>(_ url: URL, _ object: T) -> Completable where T : Encodable {
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
					let error = NSError(domain: "you could not create file at \(url.path)", code: 401, userInfo: nil)
					emitter(.error(error))
				}
			} catch {
				emitter(.error(error))
			}
			return Disposables.create()
		}
	}
}
