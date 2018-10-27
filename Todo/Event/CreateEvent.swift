//
//  CreateEvent.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class CreateEvent: Event {
	
	private let text: String
	
	init(text: String) {
		self.text = text
		super.init()
	}
	
	override func toIntent(container: Container?) -> Intent {
		if let localStorageRepository = container?.resolve(LocalStorageRepository.self) {
			return CreateIntent(localStorageRepository: localStorageRepository, text: text)
		}
		return super.toIntent(container: container)
	}
}
