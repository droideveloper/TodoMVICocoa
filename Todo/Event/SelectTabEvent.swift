//
//  SelectTabEvent.swift
//  Todo
//
//  Created by Fatih Şen on 28.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class SelectTabEvent: Event {
	
	public let display: Display
	
	init(display: Display) {
		self.display = display
	}
	
	override func toIntent(container: Container?) -> Intent {
		return SelectTabIntent(display: display)
	}
}
