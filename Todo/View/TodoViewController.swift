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
	
	// default option for now
	var display: Display = .all
	
	private var dataSet = ObservableList<Todo>()
	
  override func setUp() {
		// register data set every thime we get visible
		dataSet.register(tableView)
  }
  
  override func attach() {
    super.attach() // requires super call since it needs those
    // we will require new data concept in this segment
  }
  
  override func render(model: TodoModel) {
    // render view in here
  }
	
	override func viewDidAppear(_ animated: Bool) {
		dataSet.unregister(tableView) // we do clear our dataSet
		super.viewDidAppear(animated)
	}
	
	/// if dataSet is empty we trigger inial load event so we fill table view here
	private func checkIfInitialLoadNeeded() {
		if dataSet.isEmpty {
			accept(LoadEvent(display: display))
		}
	}
}
