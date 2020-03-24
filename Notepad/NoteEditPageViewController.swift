//
//  NoteEditPageViewController.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/24.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation
import UIKit

class NoteEditPageViewController: UIViewController {
    
    @IBOutlet weak var commitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        assignEvents()
    }
}

extension NoteEditPageViewController {
    func assignEvents() {
        commitButton.addTarget(self, action: #selector(commitButtonClickAction), for: .touchUpInside)
    }
    
    @objc
    func commitButtonClickAction() {
        dismiss(animated: true) {
            
        }
    }
}
