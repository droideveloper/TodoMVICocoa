//
//  MainViewController.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import MVICocoa
import RxSwift
import Swinject
import SwinjectStoryboard

class MainViewController: BaseViewController<DisplayModel, MainViewModel> {
	
	@IBOutlet private weak var all: TabItem!
	@IBOutlet private weak var active: TabItem!
	@IBOutlet private weak var inactive: TabItem!
	
	@IBOutlet private weak var btnAll: UIButton!
	@IBOutlet private weak var btnActive: UIButton!
	@IBOutlet private weak var btnInactive: UIButton!

	
	private let displays: [Display] = [.all, .active, .inactive]
	private lazy var tabs: [TabItem] = {
		return [all, active, inactive]
	}()
	
	private lazy var controllers: [TodoViewController] = {
		if let container = container {
			let storyBoard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
			return [storyBoard.instantiateViewController(withIdentifier: "todoViewController") as! TodoViewController,
							storyBoard.instantiateViewController(withIdentifier: "todoViewController") as! TodoViewController,
							storyBoard.instantiateViewController(withIdentifier: "todoViewController") as! TodoViewController]
		}
		return []
	}()
	
	private var selectedDisplay: Display? = nil
	
	override func setUp() {
		// initial state
		tabs.forEach { tab in tab.isChecked = false }
		controllers.forEach { controller in
			if let index = self.controllers.firstIndex(of: controller) {
				controller.display = self.displays[index]
			}
		}
	}
	
	override func attach() {
		super.attach()
		
		let allObservable = btnAll.rx.tap.map { _ in self.all }
		let activeObservable = btnActive.rx.tap.map { _ in self.active }
		let inactiveObservable = btnInactive.rx.tap.map { _ in self.inactive }
		
		disposeBag += Observable.merge(allObservable, activeObservable, inactiveObservable)
			.concatMap { tab -> Observable<Display> in
				if let tab = tab {
					if let index = self.tabs.firstIndex(of: tab) {
						return Observable.just(self.displays[index])
					}
				}
				return Observable.never()
			}
			.map { display in SelectTabEvent(display: display) }
			.subscribe(onNext: accept(_ :))
		
		checkIfInitialStateNeeded()
	}
	
	override func render(model: DisplayModel) {
		if model.state is Idle {
			showDisplay(model.data)
		} else if model.state is Failure {
			if let state = model.state as? Failure {
				showError(state.error)
			}
		}
	}
	
	private func showDisplay(_ newDispaly: Display) {
		if selectedDisplay != newDispaly {
			invalidateTabs(newDispaly)
			addSubController(newDispaly)
			selectedDisplay = newDispaly
		}
	}
	
	private func invalidateTabs(_ newDisplay: Display) {
		tabs.forEach { tab in tab.isChecked = false }
		switch newDisplay {
		case .all:
			tabs[0].isChecked = true
			break
		case .active:
			tabs[1].isChecked = true
			break
		case .inactive:
			tabs[2].isChecked = true
			break
		}
	}
	
	private func addSubController(_ newDisplay: Display) {
		controllers.forEach { controller in
			controller.detachFromParentViewController()
		}
		switch newDisplay {
			case .all:
				controllers[0].attachTo(parentViewController: self)
				break
			case .active:
				controllers[1].attachTo(parentViewController: self)
				break
			case .inactive:
				controllers[2].attachTo(parentViewController: self)
				break
		}
	}
	
	private func checkIfInitialStateNeeded() {
		if selectedDisplay == nil {
			accept(SelectTabEvent(display: .all))
		}
	}
}
