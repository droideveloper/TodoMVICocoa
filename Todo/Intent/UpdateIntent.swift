//
//  UpdateIntent.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa
import RxSwift

class UpdateIntent: ObservableIntent<TodoModel> {
	
	private let localStorageRepository: LocalStorageRepository
	private let todo: Todo
	
	init(localStorageRepository: LocalStorageRepository, todo: Todo) {
		self.todo = todo
		self.localStorageRepository = localStorageRepository
		super.init()
	}
	
	override func invoke() -> Observable<Reducer<TodoModel>> {
		return localStorageRepository.update(todo)
			.andThen(Observable.of(todo))
			.map { item in [item] }
			.subscribeOn(MainScheduler.asyncInstance)
			.delay(0.5, scheduler: MainScheduler.asyncInstance)
			.concatMap(bySuccess(_ :))
			.catchError(byFailure(_:))
			.startWith(byInitial())
	}
	
	private func byInitial() -> Reducer<TodoModel> {
		return { model in model.copy(state: idle, data: []) }
	}
	
	private func bySuccess(_ data: [Todo]) -> Observable<Reducer<TodoModel>> {
		return Observable.of(
			{ model in model.copy(state: update, data: data) },
			{ model in model.copy(state: idle, data: []) })
	}
	
	private func byFailure(_ error: Error) -> Observable<Reducer<TodoModel>> {
		return Observable.of(
			{ model in model.copy(state: Failure(error)) },
			{ model in model.copy(state: idle) })
	}
}
