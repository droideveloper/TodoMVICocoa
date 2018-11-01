//
//  StateChangedEvent.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class StateChangedEvent: Event {
	
	public let todo: Todo
	
	init(todo: Todo) {
		self.todo = todo
	}
	
	override func toIntent(container: Container?) -> Intent {
		if let localStorageRepository = container?.resolve(LocalStorageRepository.self) {
			return StateChangedIntent(todo: todo, localStorageRepository: localStorageRepository)
		}
		return self.toIntent(container: container)
	}
}
