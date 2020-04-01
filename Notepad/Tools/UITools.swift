//
//  UITools.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/4/1.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func boundingWith(font: UIFont, specifiedWith: CGFloat = CGFloat.infinity, specifiedHeight: CGFloat = CGFloat.infinity) -> CGRect {
        return NSString(string: self).boundingRect(with: CGSize(width: specifiedWith, height: specifiedHeight), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
    }
}
