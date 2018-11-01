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
	@IBOutlet private weak var view: UIView!
	
	private var disposeBag: DisposeBag!
	
	func bind(entity: Todo) {
		disposeBag = DisposeBag() // initialized in each bind since cells are reusable so we do not want to bind everythime cell invaldiated...
		
		let attributedString = NSMutableAttributedString(string: entity.title)
		let state = entity.state == .inactive || entity.state == .completed
		if state {
			attributedString.addAttributes([NSAttributedString.Key.strikethroughStyle: 2], range: NSRange(location: 0, length: attributedString.length))
		}
		viewLabelTitle.attributedText = attributedString
		viewButtonState.isChecked = state
		view.alpha = state ? 0.5 : 1
		
		disposeBag += bindStateChangedEvent(entity).subscribe(onNext: BusManager.send(event :))
	}
	
	private func bindStateChangedEvent(_ entity: Todo) -> Observable<StateChangedEvent> {
		return viewButtonState.rx.tap
			.map { _ in StateChangedEvent(todo: entity) }
	}
}
