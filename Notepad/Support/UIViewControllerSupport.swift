//
//  UIViewControllerSupport.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/25.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func autoDismiss(_ animated: Bool, dismissComplete: (() -> Void)?) {
        if navigationController != nil {
            if navigationController?.viewControllers.firstIndex(of: self) != 0 {
                navigationController?.popViewController(animated: animated)
            } else {
                dismiss(animated: animated, completion: dismissComplete)
            }
            navigationController?.popViewController(animated: animated)
        } else if navigationController == nil {
            if presentingViewController != nil {
                dismiss(animated: animated, completion: dismissComplete)
            }
        }
    }
}
