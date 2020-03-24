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
    
    let addButtonWidth: CGFloat = 60
    let tableView = UITableView()
    let addButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderSubviews()
        bindingData()
    }
}

// render
extension NoteListViewController {
    func renderSubviews() {
        view.backgroundColor = .white
        title =  NSLocalizedString("Notes", comment: "")
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        renderTableView()
        renderAddButton()
        assignEvents()
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
    
    func renderAddButton() {
//        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = addButtonWidth / 2
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 32)
        addButton.titleLabel?.textColor = .white
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(addButtonWidth)
        }
    }
}

// table view delegate
extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDataManager.default.userNoteData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteListTableCell.NoteListTableCellReusableIdentifier, for: indexPath) as? NoteListTableCell else { return UITableViewCell() }
        cell.updateCellWithNoteInfo(UserDataManager.default.userNoteData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

// event
extension NoteListViewController {
    func assignEvents() {
        addButton.addTarget(self, action: #selector(addButtonClickAction), for: .touchUpInside)
    }
    
    @objc
    func addButtonClickAction() {
        let newEditPage = NoteEditPageViewController()
        present(newEditPage, animated: true) {
            
        }
    }
}
