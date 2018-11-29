//
//  Intent.swift
//  Todo
//
//  Created by Fatih Şen on 12.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa

public typealias Operation = MVICocoa.Operation

public let create = Operation(0x02)
public let update = Operation(0x03)
public let delete = Operation(0x04)
