//
//  TodoViewController.swift
//  Todo
//
//  Created by Fatih Şen on 26.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa

class TodoViewController: BaseTableViewController<TodoModel, TodoViewModel> {
  
  override func setUp() {
    // set up your views in here
  }
  
  override func attach() {
    super.attach() // requires super call since it needs those
    // we will require new data concept in this segment
  }
  
  override func render(model: TodoModel) {
    // render view in here
  }
}
