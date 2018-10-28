//
//  EditorLayout.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

@IBDesignable
class EditorLayout: UIView {
	
	override func draw(_ rect: CGRect) {
		let path = UIBezierPath(rect: rect)
		UIColor.white.setFill()
		path.fill()
		UIColor.darkGray.setStroke()
		path.stroke()
	}
}
