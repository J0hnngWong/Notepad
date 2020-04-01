//
//  MainNavigationViewController.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/24.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderController()
        renderSubviews()
    }
}

extension MainNavigationViewController {
    func renderController() {
        let mainListVC = NoteListViewController()
        viewControllers = [mainListVC]
    }
    
    func renderSubviews() {
        
    }
}
