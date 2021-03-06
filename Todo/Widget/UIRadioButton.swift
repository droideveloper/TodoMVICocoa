//
//  RadioButton.swift
//  Todo
//
//  Created by Fatih Şen on 27.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import UIKit

class UIRadioButton: UIButton {
	
	private let selectedImage = UIImage(named: "radio_on")?.withRenderingMode(.alwaysTemplate)
	private let notSelectedImage = UIImage(named: "radio_off")?.withRenderingMode(.alwaysTemplate)
	
	var isChecked: Bool = false {
		didSet {
			if isChecked {
				setImage(selectedImage, for: .normal)
			} else {
				setImage(notSelectedImage, for: .normal)
			}
		}
	}
}
