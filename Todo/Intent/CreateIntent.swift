//
//  CreateIntent.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa
import RxSwift

public class CreateIntent: ObservableIntent<TodoModel> {
	
	private let localStorageRepository: LocalStorageRepository
	private let text: String
	
	init(localStorageRepository: LocalStorageRepository, text: String) {
		self.localStorageRepository = localStorageRepository
		self.text = text
		super.init()
	}
	
	public override func invoke() -> Observable<Reducer<TodoModel>> {
		let todo = Todo(id: UUID().uuidString, title: text, state: .active, createdAt: Date(), updatedAt: Date())
		return localStorageRepository.create(todo)
			.andThen(Observable.of(todo))
			.map { todo in [todo] }
			.subscribeOn(MainScheduler.asyncInstance)
			.delay(0.5, scheduler: MainScheduler.asyncInstance)
			.concatMap(bySuccess(_ :))
			.catchError(byFailure(_:))
			.startWith(byInitial())
	}
	
	private func byInitial() -> Reducer<TodoModel> {
		return { model in model.copy(state: create, data: [])  }
	}
	
	private func bySuccess(_ data: [Todo]) -> Observable<Reducer<TodoModel>> {
		return Observable.of(
			{ model in model.copy(state: create, data: data) },
			{ model in model.copy(state: idle, data: []) })
	}
	
	private func byFailure( _ erorr: Error) -> Observable<Reducer<TodoModel>> {
		return Observable.of(
			{ model in model.copy(state: Failure(erorr)) },
			{ model in model.copy(state: idle) })
	}
}
