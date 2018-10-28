//
//  BottomLayout.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

@IBDesignable
class BottomLayout: UIView {
	
	override func draw(_ rect: CGRect) {
		
		let rect3 = CGRect(x: 24, y: 14, width: rect.width - 48, height: 12)
		
		let layer3 = UIBezierPath(rect: rect3)
		layer3.lineWidth = 0.5
		UIColor.white.setFill()
		layer3.fill()
		UIColor.darkGray.setStroke()
		layer3.stroke()
		
		let rect2 = CGRect(x: 16, y: 7, width: rect.width - 32, height: 12)
		
		let layer2 = UIBezierPath(rect: rect2)
		layer2.lineWidth = 0.5
		UIColor.white.setFill()
		layer2.fill()
		UIColor.darkGray.setStroke()
		layer2.stroke()
		
		
		let rect1 = CGRect(x: 8, y: -2, width: rect.width - 16, height: 12)
		
		let layer1 = UIBezierPath(rect: rect1)
		layer1.lineWidth = 0.5
		UIColor.white.setFill()
		layer1.fill()
		UIColor.darkGray.setStroke()
		layer1.stroke()
		
	}
}
