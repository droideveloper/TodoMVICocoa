//
//  LoadTodoIntent.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa
import RxSwift

class LoadTodoIntent: ObservableIntent<TodoModel> {
	
	private let localStorageRepository: LocalStorageRepository
	private let display: Display
	
	init(localStorageRepository: LocalStorageRepository, display: Display) {
		self.localStorageRepository = localStorageRepository
		self.display = display
		super.init()
	}
	
	override func invoke() -> Observable<Reducer<TodoModel>> {
		return localStorageRepository.load(display)
			.subscribeOn(MainScheduler.asyncInstance)
			.delay(0.5, scheduler: MainScheduler.asyncInstance)
			.map(bySuccess(_ :))
			.catchError(byFailure(_:))
			.startWith(byInitial())
	}
	
	private func byInitial() -> Reducer<TodoModel> {
		return { model in model.copy(state: refresh) }
	}
	
	private func bySuccess(_ data: [Todo]) -> Reducer<TodoModel> {
		return { model in model.copy(state: idle, data: data) }
	}
	
	private func byFailure(_ error: Error) -> Observable<Reducer<TodoModel>> {
		return Observable.of(
			{ model in model.copy(state: Failure(error)) },
			{ model in model.copy(state: idle) })
	}
}
