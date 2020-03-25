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
    
    // UI element
    @IBOutlet weak var pageTitleLabel: UILabel!
    
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteDetailLabel: UILabel!
    @IBOutlet weak var noteDetailTextField: UITextField!
    
    @IBOutlet weak var commitButton: UIButton!
    
    // data
    var note: Note
    
    init(_ note: Note) {
        self.note = note
        super.init(nibName: "NoteEditPageViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        assignEvents()
    }
}

extension NoteEditPageViewController {
    func renderSubviews() {
        pageTitleLabel.text = NSLocalizedString("NewNote", comment: "")
        noteTitleLabel.text = NSLocalizedString("Title", comment: "")
        noteDetailLabel.text = NSLocalizedString("Detail", comment: "")
        
        commitButton.layer.cornerRadius = commitButton.bounds.width / 2
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
        dismiss(animated: true) {
            
        }
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
    }
    
}
