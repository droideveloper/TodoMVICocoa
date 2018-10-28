//
//  MainViewModel.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa
import RxSwift

class MainViewModel: BaseViewModel<DisplayModel> {
	
	private weak var view: MainViewController?
	
	init(view: MainViewController) {
		self.view = view
	}
	
	override func attach() {
		super.attach()
		if let view = view {
			// will bind in here
			disposeBag += view.viewEvents()
				.toIntent(view.container)
				.subscribe(onNext: accept(_ :))
		}
	}
}
