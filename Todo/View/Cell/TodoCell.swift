//
//  TodoCell.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MVICocoa

class TodoCell: UITableViewCell {
	
	@IBOutlet private weak var viewButtonState: UIRadioButton!
	@IBOutlet private weak var viewLabelTitle: UILabel!
	
	private let disposeBag = DisposeBag()
	
	func bind(entity: Todo) {
		
		let attributedString = NSMutableAttributedString(string: entity.title)
		if entity.state == .inactive || entity.state == .completed {
			attributedString.addAttributes([NSAttributedString.Key.strikethroughStyle: 2], range: NSRange(location: 0, length: attributedString.length))
		}
		viewLabelTitle.attributedText = attributedString
		viewButtonState.isChecked = entity.state != .active
		
		disposeBag += bindStateChangedEvent(entity).subscribe(onNext: BusManager.send(event :))
	}
	
	private func bindStateChangedEvent(_ entity: Todo) -> Observable<StateChangedEvent> {
		return viewButtonState.rx.tap.map { _ in entity.copy(state: entity.state == .active ? .inactive : .active) }
			.map { todo in StateChangedEvent(todo: todo) }
	}
}
