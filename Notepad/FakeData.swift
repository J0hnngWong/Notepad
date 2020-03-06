//
//  FakeData.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/4.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation

let fakeUserData: [Note] = getData()

func getData() -> Array<Note> {
    var resultArray: [Note] = []
    
    for item in 0...10 {
        let note = Note(title: "title\(item)", detail: "detail\(item)", date: Date())
        resultArray.append(note)
    }
    
    return resultArray
}
