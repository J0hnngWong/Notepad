//
//  NoteList.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/3.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import SwiftUI

struct NoteList: View {
    @State private var isPresented = false
    @EnvironmentObject private var userData: UserDataManager
    
    let addButtonHeight: CGFloat = 50
    var body: some View {
        NavigationView {
            VStack {
                if userData.userNoteData.count > 0 {
                    List {
                        ForEach(userData.userNoteData) { note in
                            NavigationLink(destination: NoteEditPage(userData: self.userData, pageType: .edit, noteInfo: note, onCommit: {
                                self.userData.retriveAllUserNoteData()
                            })) {
                                NoteListCell(note: note)
                            }
                        }
                        .onDelete { (indexSet) in
                            print("userNoteData:  \(self.userData.userNoteData)")
                            for index in indexSet {
                                self.userData.deleteNote(by: self.userData.userNoteData[index].id, complete: nil)
                            }
//                            self.userData.userNoteData.remove(atOffsets: indexSet) //如果remove的话会由于数据排序问题出现错误删除，由于数据与UI同步所以其实不需要remove这个cell
                        }
                    }
    //                .navigationBarTitle(Text("NoteList"), displayMode: .large)
                    .padding(.bottom, -addButtonHeight)
                } else {
                    Spacer()
                }
                
                
                Button("Add") {
                    self.isPresented = true
                }
                .sheet(isPresented: $isPresented, onDismiss: {
                    self.isPresented = false
                }) {
                    NoteEditPage(userData: self.userData, pageType: .new, noteInfo:Note(id: UUID(), title: "", detail: "", date: Date()), onCommit: {
                        self.userData.retriveAllUserNoteData()
                    })
                }
                .frame(width: addButtonHeight, height: addButtonHeight)
            }
            .navigationBarTitle(Text("NoteList"), displayMode: .large)
        }
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
            .environmentObject(UserDataManager())
    }
}
