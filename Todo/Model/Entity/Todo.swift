//
//  Todo.swift
//  Todo
//
//  Created by Fatih Şen on 26.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

public struct Todo: Codable {
  
  public static let empty = Todo()
  
  var id: String = UUID().uuidString
  var title = String.empty
  var state: State = .active
  var createdAt = Date()
  var updatedAt = Date()
  
  public func copy(id: String? = nil, title: String? = nil, state: State? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) -> Todo {
    return Todo(id: id ?? self.id,
                title: title ?? self.title,
                state: state ?? self.state,
                createdAt: createdAt ?? self.createdAt,
                updatedAt: updatedAt ?? self.updatedAt)
  }
}
