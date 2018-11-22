//
//  TodoViewController.swift
//  Todo
//
//  Created by Fatih Şen on 26.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa

class TodoViewController: BaseTableViewController<TodoModel, TodoViewModel>, Loggable {
	
	// default option for now
	var display: Display = .all
	
	private var dataSet = ObservableList<Todo>()
	private lazy var dataSource = {
		return TodoDataSource(dataSet: dataSet)
	}()
	
  override func setUp() {
		refreshControl = UIRefreshControl()
		refreshControl?.tintColor = UIColor.darkText
		
		// register data set every thime we get visible
		dataSet.register(tableView)
		// table view
		let nib = UINib(nibName: "TodoCell", bundle: Bundle.main)
		tableView.register(nib, forCellReuseIdentifier: TodoDataSource.kTodoCell)
		// style
		tableView.separatorStyle = .none
		// register data source
		tableView.dataSource = dataSource
  }
  
  override func attach() {
    super.attach() // requires super call since it needs those
    // we will require new data concept in this segment
		disposeBag += BusManager.register(accept(_:)) // event will com from third party or parent pipeline
	
		checkIfInitialLoadNeeded()
  }
  
  override func render(model: TodoModel) {
    // render view in here
		if let state = model.state as? Operation {
			if state == create {
				if display == .all || display == .active {
					dataSet.append(model.data)
				}
			} else if state == update {
				if display == .all {
					if let todo = model.data.first {
						let position = dataSet.indexOf(todo)
						if position != -1 {
							dataSet.put(at: position, value: todo)
						}
					}
				} else if display == .active || display == .inactive {
					if let todo = model.data.first {
						let position = dataSet.indexOf(todo)
						if position != -1 {
							dataSet.remove(at: position)
						}
					}
				}
			}
		} else if model.state is Idle {
			dataSet.append(model.data)
		}
		log("\(model.data) state: \(model.state) for: \(display)")
  }
	
	override func viewDidDisappear(_ animated: Bool) {
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
