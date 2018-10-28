//
//  DisplayModel.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa

public struct DisplayModel: Model {
	public typealias Entity = Display

	public static var empty = DisplayModel(state: idle, data: .all)
	
	public var state: SyncState
	public var data: Display
	
	public func copy(state: SyncState? = nil, data: Display? = nil) -> DisplayModel {
		return DisplayModel(state: state ?? self.state, data: data ?? self.data)
	}
}
