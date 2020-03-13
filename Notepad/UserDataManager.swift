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
        DataBaseManager.sharedManager.searchNote(by: nil) { [weak self] (NoteEntity) -> (Void) in
            print("\(NoteEntity)")
            
            self?.userNoteData = self?.sortNoteByDate(with: self?.mapToNoteSet(with: NoteEntity) ?? []) ?? []
        }
    }
    
    func deleteNote(by id: UUID, complete: ((Bool) -> Void)?) {
        DataBaseManager.sharedManager.deleteNote(by: id) { [weak self] (NoteEntity) -> (Void) in
            print("\(NoteEntity)")
            self?.retriveAllUserNoteData()
        }
    }
    
    func insertNewNote(note: Note, complete: ((Bool) -> Void)?) {
        DataBaseManager.sharedManager.insertNote(note: note) { [weak self] (NoteEntity) -> (Void) in
            print("\(NoteEntity)")
            self?.retriveAllUserNoteData()
        }
    }
    
    func updateNote(by id: UUID, note: Note, complete: ((Bool) -> Void)?) {
        DataBaseManager.sharedManager.updateNote(by: id, title: note.title, detail: note.detail, date: note.date) { [weak self] (NoteEntity) -> (Void) in
            print("\(NoteEntity)")
            self?.retriveAllUserNoteData()
        }
    }
    
    
}

extension UserDataManager {
    func mapToNoteSet(with noteEntitySet: Array<NoteEntity>) -> Array<Note> {
        var noteArray: [Note] = []
        for noteEntity in noteEntitySet {
            let note = mapToNote(with: noteEntity)
            noteArray.append(note)
        }
        return noteArray
    }
    
    func mapToNote(with noteEntity: NoteEntity) -> Note {
        let noteId = noteEntity.id ?? UUID()
        let noteTitle = noteEntity.title ?? ""
        let noteDetail = noteEntity.detail ?? ""
        let noteDate = noteEntity.date ?? Date()
        return Note(id: noteId, title: noteTitle, detail: noteDetail, date: noteDate)
    }
    
    func sortNoteByDate(with notes: Array<Note>) -> Array<Note> {
//        return Tools.mergeSort(list: notes) { return $0.date > $1.date }
        return notes.sorted { return $0.date > $1.date }
    }
}
