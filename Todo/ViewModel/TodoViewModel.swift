//
//  TodoViewModel.swift
//  Todo
//
//  Created by Fatih Şen on 26.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import RxSwift
import MVICocoa

class TodoViewModel: BaseViewModel<TodoModel> {
  
  private weak var view: TodoViewController?
  
  init(view: TodoViewController) {
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
