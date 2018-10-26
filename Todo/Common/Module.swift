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
  }
}
