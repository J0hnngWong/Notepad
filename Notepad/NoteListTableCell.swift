//
//  NoteListTableCell.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/24.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation
import UIKit

class NoteListTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    static let NoteListTableCellReusableIdentifier = "NoteListTableCellReusableIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension NoteListTableCell {
    public func updateCellWithNoteInfo(_ note: Note) {
        titleLabel.text = note.title
        detailLabel.text = note.detail
    }
}
