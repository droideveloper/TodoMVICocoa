//
//  TodoModel.swift
//  Todo
//
//  Created by Fatih Şen on 26.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa

public struct TodoModel: Model {
  public typealias Entity = [Todo]

  public static var empty = TodoModel(state: idle, data: [])
  
  public var state: SyncState
  public var data: [Todo]
  
  public func copy(state: SyncState?, data: [Todo]?) -> TodoModel {
    return TodoModel(state: state ?? self.state, data: data ?? self.data)
  }
}
