//
//  NoteEditPageViewController.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/24.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation
import UIKit

enum NoteEditPageType {
    case new
    case edit
}

class NoteEditPageViewController: UIViewController {
    
    // UI element
    @IBOutlet weak var pageTitleLabel: UILabel!
    
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteDetailLabel: UILabel!
    @IBOutlet weak var noteDetailTextField: UITextField!
    @IBOutlet weak var lastEditDateLabel: UILabel!
    
    @IBOutlet weak var commitButton: UIButton!
    
    // data
    var note: Note
    var pageType: NoteEditPageType
    
    init(_ pageType: NoteEditPageType, _ note: Note) {
        self.note = note
        self.pageType = pageType
        super.init(nibName: "NoteEditPageViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        renderSubviews()
        assignEvents()
    }
}

extension NoteEditPageViewController {
    func renderSubviews() {
        pageTitleLabel.text = NSLocalizedString("NewNote", comment: "")
        noteTitleLabel.text = NSLocalizedString("Title", comment: "")
        noteDetailLabel.text = NSLocalizedString("Detail", comment: "")
        
        switch pageType {
        case .new:
            pageTitleLabel.isHidden = false
            commitButton.isHidden = false
            lastEditDateLabel.isHidden = true
        case .edit:
            pageTitleLabel.isHidden = true
            commitButton.isHidden = true
            lastEditDateLabel.isHidden = false
        }
        
        noteTitleTextField.text = note.title
        noteDetailTextField.text = note.detail
        lastEditDateLabel.text = "\(NSLocalizedString("LastEditDate", comment: "")): \n \(note.date)"
        
        commitButton.layer.cornerRadius = commitButton.bounds.height / 2
        commitButton.isEnabled = !(noteTitleTextField.text?.isEmpty ?? true)
        commitButton.setTitle(NSLocalizedString("Commit", comment: ""), for: .normal)
    }
}

extension NoteEditPageViewController {
    func assignEvents() {
        commitButton.addTarget(self, action: #selector(commitButtonClickAction), for: .touchUpInside)
        noteTitleTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        noteDetailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
    }
    
    @objc
    func commitButtonClickAction() {
        if pageType == .new {
            UserDataManager.default.insertNewNote(note: note) { (result) in
            }
        } else if pageType == .edit {
            UserDataManager.default.updateNote(by: note.id, note: note) { (result) in
            }
        } else {
            // notice user there is no page type like this
        }
        autoDismiss(true, dismissComplete: nil)
    }
}

extension NoteEditPageViewController: UITextFieldDelegate {
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        if textField == noteTitleTextField {
            note.title = textField.text ?? ""
        } else if textField == noteDetailTextField {
            note.detail = textField.text ?? ""
        }
        
        commitButton.isEnabled = !(noteTitleTextField.text?.isEmpty ?? true)
    }
    
}
