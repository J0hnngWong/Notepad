//
//  NoteListViewController.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/24.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

// property
class NoteListViewController: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderSubviews()
    }
}

// render
extension NoteListViewController {
    func renderSubviews() {
        view.backgroundColor = .red
        renderTableView()
        bindingData()
    }
    
    func renderTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.register(UINib(nibName: "NoteListTableCell", bundle: Bundle.main), forCellReuseIdentifier: NoteListTableCell.NoteListTableCellReusableIdentifier)
        tableView.tableFooterView = UIView()
    }
}

// table view delegate
extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDataManager.default.userNoteData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteListTableCell.NoteListTableCellReusableIdentifier, for: indexPath)
        return cell
    }
}

// data binding

extension NoteListViewController {
    func bindingData() {
        NotificationCenter.default.addObserver(forName: .UserNoteDataUpdateNotification, object: nil, queue: OperationQueue.main) { (notification) in
            self.tableView.reloadData()
        }
    }
}
