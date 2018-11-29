//
//  LoadTodoEvent.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class LoadEvent: Event {
	
	private let display: Display
	
	init(display: Display) {
		self.display = display
		super.init()
	}
	
	override func toIntent(container: Container?) -> Intent {
		if let localStorageRepository = container?.resolve(LocalStorageRepository.self) {
			return LoadIntent(localStorageRepository: localStorageRepository, display: display)
		}
		return super.toIntent(container: container)
	}
}
