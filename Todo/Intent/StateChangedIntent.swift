//
//  StateChangedIntent.swift
//  Todo
//
//  Created by Fatih Şen on 1.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa
import RxSwift

class StateChangedIntent: ObservableIntent<TodoModel> {
	
	private let todo: Todo
	private let localStorageRepository: LocalStorageRepository
	
	init(todo: Todo, localStorageRepository: LocalStorageRepository) {
		self.localStorageRepository = localStorageRepository
		self.todo = todo
		super.init()
	}
	
	override func invoke() -> Observable<Reducer<TodoModel>> {
		let state: State = self.todo.state == .active ? .inactive : .active
		let todo = self.todo.copy(state: state)
		return localStorageRepository.update(todo)
			.andThen(Observable.of(todo))
			.map { todo in [todo] }
			.subscribeOn(MainScheduler.asyncInstance)
			.delay(0.5, scheduler: MainScheduler.asyncInstance)
			.concatMap(bySuccess(_:))
			.catchError(byFailure(_:))
			.startWith(byInitial())
	}
	
	private func byInitial() -> Reducer<TodoModel> {
		return { model in model.copy(state: idle, data: []) }
	}
	
	private func bySuccess(_ todo: [Todo]) -> Observable<Reducer<TodoModel>> {
		return Observable.of(
			{ model in model.copy(state: update, data: todo) },
			{ model in model.copy(state: idle, data: []) })
	}
	
	private func byFailure(_ error: Error) -> Observable<Reducer<TodoModel>> {
		return Observable.of(
			{ model in model.copy(state: Failure(error), data: []) },
			{ model in model.copy(state: idle, data: []) })
	}
}
