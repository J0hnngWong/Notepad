//
//  NoteList.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/3.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import SwiftUI

struct NoteList: View {
    @EnvironmentObject private var userData: UserDataManager
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(userData.userNoteData) { note in
                    NavigationLink(destination: NoteEditPage(title: note.title, detail: note.detail)) {
                        NoteListCell(note: note)
                    }
                }
                .onDelete { (indexSet) in
                    self.userData.userNoteData.remove(atOffsets: indexSet)
                }
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
