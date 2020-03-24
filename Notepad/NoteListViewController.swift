//
//  NoteListViewController.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/24.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation
import UIKit

class NoteListViewController: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderSubviews()
    }
}

extension NoteListViewController {
    func renderSubviews() {
        view.backgroundColor = .red
        view.addSubview(tableView)
    }
}
