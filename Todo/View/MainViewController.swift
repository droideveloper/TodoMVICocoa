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
import RxCocoa
import Swinject
import SwinjectStoryboard

class MainViewController: BaseViewController<DisplayModel, MainViewModel> {
	
	@IBOutlet private weak var all: TabItem!
	@IBOutlet private weak var active: TabItem!
	@IBOutlet private weak var inactive: TabItem!
	
	@IBOutlet private weak var btnAll: UIButton!
	@IBOutlet private weak var btnActive: UIButton!
	@IBOutlet private weak var btnInactive: UIButton!

	@IBOutlet private weak var textFeild: UITextField!
	
	private let displays: [Display] = [.all, .active, .inactive]
	private lazy var tabs: [TabItem] = {
		return [all, active, inactive]
	}()
	
	private lazy var storyBoard: UIStoryboard = {
		if let container = container {
			return SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
		}
		fatalError("we can not resolve container injection so long")
	}()
	
	private var selectedDisplay: Display? = nil
	private var controller: TodoViewController? = nil
	
	override func setUp() {
		// initial state
		tabs.forEach { tab in tab.isChecked = false } // clear state at set up
	}
	
	override func attach() {
		super.attach()
		disposeBag += textFeild.rx.controlEvent(.editingDidEndOnExit)
			.asObservable()
			.map { _ in self.textFeild.text ?? String.empty }
			.filter { text in text != String.empty }
			.map { text in CreateEvent(text: text) }
			.do(onNext: { _ in self.textFeild.text = nil })
			.subscribe(onNext: BusManager.send)
		
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
		uncheckSelectedTabs()
		checkTab(newDisplay)
	}
	
	private func addSubController(_ newDisplay: Display) {
		attachControlerForDispaly(newDisplay)
	}
	
	private func checkIfInitialStateNeeded() {
		if selectedDisplay == nil {
			accept(SelectTabEvent(display: .all))
		}
	}
	
	private func uncheckSelectedTabs() {
		tabs.filter { tab in tab.isChecked }
			.forEach { tab in tab.isChecked = false }
	}
	
	private func checkTab(_ newDisplay: Display) {
		let position = displays.firstIndex(of: newDisplay) ?? -1
		if position != -1 {
			tabs[position].isChecked = true
		}
	}
	
	private func attachControlerForDispaly(_ newDisplay: Display) {
		controller?.detachFromParentViewController() // if there is value we will detach it first
		controller = storyBoard.instantiateViewController(withIdentifier: "todoViewController") as? TodoViewController
		controller?.display = newDisplay
		controller?.attachTo(parentViewController: self)
	}
}
