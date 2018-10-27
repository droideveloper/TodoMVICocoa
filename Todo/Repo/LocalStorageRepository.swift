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
	func create(_ value: Todo) -> Completable
	func delete(_ value: Todo) -> Completable
	func update(_ value: Todo) -> Completable
	func load(_ display: Display) -> Observable<[Todo]>
}
