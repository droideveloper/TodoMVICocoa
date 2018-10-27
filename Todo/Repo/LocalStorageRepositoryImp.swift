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
	
	private var dataSet = Array<Todo>()
	private let fileRepository: FileRepository
	
	init(fileRepository: FileRepository) {
		self.fileRepository = fileRepository
	}
	
	func create(_ value: Todo) -> Completable {
		return Completable.create { emitter in
			
			self.dataSet.append(value)
			emitter(.completed)
			
			return Disposables.create()
		}.andThen(persist()) // with any change we do persist it 
	}
	
	func delete(_ value: Todo) -> Completable {
		return Completable.create { emitter in
			
			if let index = self.dataSet.firstIndex(of: value) {
				self.dataSet.remove(at: index)
			}
			emitter(.completed)
			
			return Disposables.create()
	  }.andThen(persist()) // with any change we do persist it
	}
	
	func update(_ value: Todo) -> Completable {
		return Completable.create { emitter in
			if let index = self.dataSet.firstIndex(of: value) {
				self.dataSet[index] = value
			}
			emitter(.completed)
			
			return Disposables.create()
		}.andThen(persist()) // in any change we do persist it
	}
	
	func load(_ display: Display) -> Observable<[Todo]> {
		return deserialize() // read from file system
			.flatMap { items in Observable.from(items) }
			.enumerated()
			.filter { index, item in return self.filter(display: display, index, item: item) }
			.map { _, item in item }
			.toArray()
	}
	
	private func filter(display: Display, _: Int, item: Todo) -> Bool {
		switch display {
		case .all:
			return true
		case .active:
			return item.state == .active
		case .inactive:
			return item.state == .inactive || item.state == .completed
		}
	}
	
	private func deserialize() -> Observable<[Todo]> {
		return fileRepository.read(fileRepository.url, [Todo].self)
	}
	
	private func persist() -> Completable {
		return fileRepository.write(fileRepository.url, dataSet)
	}
}
