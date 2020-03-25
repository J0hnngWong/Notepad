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
    
    var notesData: [Note] = [] {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderSubviews()
        bindingData()
        UserDataManager.default.retriveAllUserNoteData()
    }
    
    deinit {
        /// 移除通知
        NotificationCenter.default.removeObserver(self)
    }
}

// render
extension NoteListViewController {
    func renderSubviews() {
        view.backgroundColor = .white
        title =  NSLocalizedString("Notes", comment: "")
        navigationItem.largeTitleDisplayMode = .always
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
        return notesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteListTableCell.NoteListTableCellReusableIdentifier, for: indexPath) as? NoteListTableCell else { return UITableViewCell() }
        cell.updateCellWithNoteInfo(notesData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notesData[indexPath.row]
        let vc = NoteEditPageViewController(.edit, note)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // batch update is perform a real action after the animation complete
            let deleteNote = notesData[indexPath.row]
            tableView.performBatchUpdates({
                notesData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
            }) { (result) in
                UserDataManager.default.deleteNote(by: deleteNote.id) { (result) in
                }
            }
        }
    }
}

// data binding

extension NoteListViewController {
    func bindingData() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataForTableView), name: .UserNoteDataUpdateNotification, object: nil)
    }
}

// event
extension NoteListViewController {
    func assignEvents() {
        addButton.addTarget(self, action: #selector(addButtonClickAction), for: .touchUpInside)
    }
    
    @objc
    func addButtonClickAction() {
        let newNote = Note(id: UUID(), title: "", detail: "", date: Date())
        let newEditPage = NoteEditPageViewController(.new, newNote)
        present(newEditPage, animated: true) {
            
        }
    }
    
    @objc
    func reloadDataForTableView() {
        notesData = UserDataManager.default.userNoteData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
