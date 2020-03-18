//
//  NoteListCell.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/3.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import SwiftUI

struct NoteListCell: View {
    var note: Note
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(note.title)
                    .font(.custom("Avenir-Book", size: 18))
                Text(note.detail)
                    .foregroundColor(Color.gray)
                    .font(.custom("Avenir-Book", size: 14))
            }
            Spacer()
//            Image(systemName: "star.fill")
//                .foregroundColor(Color.yellow)
        }
        .padding()
    }
}

struct NoteListCell_Previews: PreviewProvider {
    static var previews: some View {
        NoteListCell(note: fakeUserData[0])
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
