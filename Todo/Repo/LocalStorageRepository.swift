//
//  LocalStorageRepository.swift
//  Todo
//
//  Created by Fatih Şen on 26.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public protocol LocalStorageRepository {
  func load() -> Observable<[Todo]>
}
