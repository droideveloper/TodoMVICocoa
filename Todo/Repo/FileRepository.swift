//
//  FileRepository.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

protocol FileRepository {
	
	var url: URL { get }
	
	func read<T: Decodable>(_ url: URL, _ type: T.Type) -> Observable<T>
	func write<T: Encodable>(_ url: URL, _ object: T) -> Completable
}
