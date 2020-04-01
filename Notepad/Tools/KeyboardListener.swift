//
//  KeyboardListener.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/25.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation
import Combine
import UIKit

final class KeyboardListener {
    
    private var notificationCenter: NotificationCenter
    private(set) var currentHeight: CGFloat = 0
    
    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
            print("\(currentHeight)")
        }
    }
    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
        print("\(currentHeight)")
    }
//    the way to adjust the frame
//    scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
//    scrollView.setContentOffset(CGPoint(x: 0, y: 300), animated: true)
}
