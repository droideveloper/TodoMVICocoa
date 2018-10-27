//
//  Todo.swift
//  Todo
//
//  Created by Fatih Şen on 26.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

public struct Todo: Codable, Equatable {
  
	public static let empty = Todo(id: String.empty, title: String.empty, state: .active, createdAt: Date(), updatedAt: Date())
  
  let id: String
	let title: String
  let state: State
	let createdAt: Date
	let updatedAt: Date
  
  public func copy(id: String? = nil, title: String? = nil, state: State? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) -> Todo {
    return Todo(id: id ?? self.id,
                title: title ?? self.title,
                state: state ?? self.state,
                createdAt: createdAt ?? self.createdAt,
                updatedAt: updatedAt ?? self.updatedAt)
  }
	
	public static func == (lhs: Todo, rhs: Todo) -> Bool {
		return lhs.id == rhs.id
	}
}
