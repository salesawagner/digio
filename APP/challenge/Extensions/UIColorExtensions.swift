//
//  UIColorExtensions.swift
//  challenge
//
//  Created by Wagner Sales on 19/02/24.
//

import UIKit

extension UIColor {
    // swiftlint:disable:next identifier_name
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }

    struct Base {
        static var background = UIColor.white
        static var title = UIColor(r: 37, g: 44, b: 76)
    }
}
