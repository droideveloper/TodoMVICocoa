//
//  TodoDataSource.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift
import UIKit
import MVICocoa

class TodoDataSource: NSObject, UITableViewDataSource {

	static let kTodoCell = "kTodoCell"
	private let dataSet: ObservableList<Todo>
	
	init(dataSet: ObservableList<Todo>) {
		self.dataSet = dataSet
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSet.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TodoDataSource.kTodoCell)
		if let cell = cell as? TodoCell {
			cell.bind(entity: dataSet.get(indexPath.row))
			return cell
		}
		fatalError("we could not recognize cell for given identifiers")
	}
	
}
