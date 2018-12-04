//
//  TodoDataSource.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import RxSwift
import UIKit
import MVICocoa

class TodoDataSource: TableDataSource<Todo> {

	private let kTodoCell = String(describing: TodoCell.self)
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func bind(_ cell: UITableViewCell, _ item: Todo) {
		if let cell = cell as? TodoCell {
			cell.bind(entity: item)
		}
	}
	
	override func identifierAt(_ indextPath: IndexPath) -> String {
		return kTodoCell
	}
}
