//
//  TodoState.swift
//  Todo
//
//  Created by Fatih Şen on 26.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

public enum State: Int, Codable {
  case active = 1
  case inactive = 2
  case completed = 3
}
