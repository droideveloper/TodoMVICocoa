//
//  File.swift
//  Todo
//
//  Created by Fatih Şen on 26.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import MVICocoa

class Module {
  
  let container: Container
  
  init(container: Container) {
    self.container = container
		
		self.container.storyboardInitCompleted(MainViewController.self, initCompleted: {_, controller in
			controller.viewModel = MainViewModel(view: controller)
		})
		
		self.container.storyboardInitCompleted(TodoViewController.self, initCompleted: {_, controller in
			controller.viewModel = TodoViewModel(view: controller)
		})
		
		self.container.register(FileRepository.self, factory: { _ in FileRepositoryImp() })
		
		self.container.register(LocalStorageRepository.self, factory: { resolver in
			if let fileRepository = resolver.resolve(FileRepository.self) {
				return LocalStorageRepositoryImp(fileRepository: fileRepository)
			}
			fatalError("can not resolve \(FileRepository.self)")
		})
  }
}
