//
//  TabItem.swift
//  Todo
//
//  Created by Fatih Şen on 28.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TabItem: UIView {
	
	@IBOutlet private weak var viewSeperator: UIView!
	
	var isChecked: Bool = false {
		didSet {
			viewSeperator.alpha = isChecked ? 1 : 0
		}
	}
}
