//
//  NoteEditPage.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/4.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import SwiftUI

struct NoteEditPage: View {
    
    @State var userData: UserDataManager
    @State var pageType: EditPageType
    @State var noteInfo: Note
    @ObservedObject var keyboardListener = KeyboardListener()
    @State var paddingValue: CGFloat = 0
    @Environment(\.presentationMode) var presentation
    
//    let commitEvent: (NoteEditPage) -> () = { (noteEditInstance) in
//        if(!noteEditInstance.noteInfo.title.isEmpty && noteEditInstance.pageType == .new) {
//            noteEditInstance.userData.insertNewNote(note: Note(id: UUID(), title: noteEditInstance.noteInfo.title, detail: noteEditInstance.noteInfo.detail, date: Date()), complete: nil)
//        } else if(!noteEditInstance.noteInfo.title.isEmpty && noteEditInstance.pageType == .edit) {
//            noteEditInstance.userData.updateNote(by: noteEditInstance.noteInfo.id, note: Note(id: noteEditInstance.noteInfo.id, title: noteEditInstance.noteInfo.title, detail: noteEditInstance.noteInfo.detail, date: Date()), complete: nil)
//        }
//    }
    
    var onCommit: (() -> Void)?
    
    var body: some View {
        ScrollView {
            VStack {
                if pageType == .new {
                    Spacer(minLength: 30)
                    Text("New Note")
                } else {
                    Text("Edit Note")
                }
                
                VStack {
                    TextField("Title", text: $noteInfo.title, onEditingChanged: { (onEdit) in
                        
                    }) {
                        
                    }
//                      .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width - 32, height: 2, alignment: .center)
                        .background(Color.primary)
                }
                .padding()
                
                Spacer()
                    .frame(height: 30)
                
                VStack {
                    TextField("detail", text: $noteInfo.detail, onEditingChanged: { (value) in
                        
                    }) {
                        
                    }
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.body)
                    .foregroundColor(.black)
                    
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width - 32, height: 1, alignment: .center)
                        .background(Color.secondary)
                }
                .padding()
                
                if pageType == .new {
                    Spacer()
                        .frame(height: 30)
                    Button(action: {
                        if(!self.noteInfo.title.isEmpty && self.pageType == .new) {
                            self.userData.insertNewNote(note: Note(id: UUID(), title: self.noteInfo.title, detail: self.noteInfo.detail, date: Date()), complete: nil)
                        } else if(!self.noteInfo.title.isEmpty && self.pageType == .edit) {
                            self.userData.updateNote(by: self.noteInfo.id, note: Note(id: self.noteInfo.id, title: self.noteInfo.title, detail: self.noteInfo.detail, date: Date()), complete: nil)
                        }
                        self.onCommit?()
                        self.presentation.wrappedValue.dismiss()
                        
                    }) {
                        Text("Commit")
                            .frame(width: 80, height: 36, alignment: .center)
                            .background(Color.blue)
                            .foregroundColor(.black)
                            .cornerRadius(40)
                    }
                }
            }
        }
        .padding(.bottom, keyboardListener.currentHeight)
        .navigationBarItems(trailing: Button(action: {
            if(!self.noteInfo.title.isEmpty && self.pageType == .new) {
                self.userData.insertNewNote(note: Note(id: UUID(), title: self.noteInfo.title, detail: self.noteInfo.detail, date: Date()), complete: nil)
            } else if(!self.noteInfo.title.isEmpty && self.pageType == .edit) {
                self.userData.updateNote(by: self.noteInfo.id, note: Note(id: self.noteInfo.id, title: self.noteInfo.title, detail: self.noteInfo.detail, date: Date()), complete: nil)
            }
            self.onCommit?()
            self.presentation.wrappedValue.dismiss()
            
        }) {
            Text("Commit")
        })
    }
}

struct NoteEditPage_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditPage(userData: UserDataManager(), pageType: .new, noteInfo: Note(id: UUID(), title: "Title", detail: "detail", date: Date()))
    }
}

enum EditPageType {
    case new
    case edit
}
