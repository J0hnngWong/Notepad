//
//  KeyboardListener.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/10.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation
import Combine
import UIKit

final class KeyboardListener: ObservableObject {
    
    private var notificationCenter: NotificationCenter
    @Published private(set) var currentHeight: CGFloat = 0
    
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
}
