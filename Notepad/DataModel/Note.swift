//
//  Note.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/4.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation

struct Note: Hashable, Codable, Identifiable {
    var id: UUID
    var title: String
    var detail: String
    var date: Date
    
    init(id: UUID, title: String, detail: String, date: Date) {
        self.id = id
        self.title = title
        self.detail = detail
        self.date = date
    }
    
    func isEmptyNote() -> Bool {
        return title.isEmpty
    }
}
