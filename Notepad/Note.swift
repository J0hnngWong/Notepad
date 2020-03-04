//
//  Note.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/4.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation

struct Note: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var detail: String
    var date: Date
}
