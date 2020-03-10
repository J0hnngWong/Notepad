//
//  UserDataManager.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/4.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import SwiftUI
import Combine

final class UserDataManager: ObservableObject {
//    @Published var showFavoritesOnly = false
    @Published var userNoteData = fakeUserData
    
    func retriveAllUserNoteData() {
        DataBaseManager.sharedManager.searchNote(by: nil) { [weak self] (result) -> (Void) in
            print("\(result)")
            var noteArray: [Note] = []
            
            for noteEntity in result {
                let noteId = noteEntity.id ?? UUID()
                let noteTitle = noteEntity.title ?? ""
                let noteDetail = noteEntity.detail ?? ""
                let noteDate = noteEntity.date ?? Date()
                let note = Note(id: noteId, title: noteTitle, detail: noteDetail, date: noteDate)
                noteArray.append(note)
            }
            
            self?.userNoteData = noteArray
        }
    }
}
