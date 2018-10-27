//
//  StateChangedEvent.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa

class StateChangedEvent: Event {
	
	public let todo: Todo
	
	init(todo: Todo) {
		self.todo = todo
	}
}
