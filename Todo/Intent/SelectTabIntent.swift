//
//  SelectTabIntent.swift
//  Todo
//
//  Created by Fatih Şen on 28.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa

class SelectTabIntent: ReducerIntent<DisplayModel> {
	
	private let display: Display
	
	init(display: Display) {
		self.display = display
	}
	
	override func invoke() -> Reducer<DisplayModel> {
		return { model in model.copy(state: idle, data: self.display) }
	}
}
