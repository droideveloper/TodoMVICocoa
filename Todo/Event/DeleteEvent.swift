//
//  DeleteEvent.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class DeleteEvent: Event {
	
	private let todo: Todo
	
	init(todo: Todo) {
		self.todo = todo
		super.init()
	}
	
	override func toIntent(container: Container?) -> Intent {
		if let localStorageRepository = container?.resolve(LocalStorageRepository.self) {
			return DeleteIntent(localStorageRepository: localStorageRepository, todo: todo)
		}
		return super.toIntent(container: container)
	}
	
}
