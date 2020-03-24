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
    
    static let NoteListTableCellReusableIdentifier = "NoteListTableCellReusableIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .red
    }
}
