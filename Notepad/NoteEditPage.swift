//
//  NoteEditPage.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/4.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import SwiftUI

struct NoteEditPage: View {
    
    @State var title: String
    @State var detail: String
    @ObservedObject var keyboardListener = KeyboardListener()
    @State var paddingValue: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Note Detail")
                TextField("title", text: $title, onEditingChanged: { (value) in
                    
                }) {
                    
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
                .foregroundColor(.black)
                .padding()
                TextField("detail", text: $detail, onEditingChanged: { (value) in
                    
                }) {
                    
                }
                .frame(height: 60, alignment: .leading)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.body)
                .foregroundColor(.black)
                .padding()
            }
        }
        .padding(.bottom, keyboardListener.currentHeight)
        .navigationBarItems(trailing: commitButton())
    }
}

struct NoteEditPage_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditPage(title: "title", detail: "detail")
    }
}

struct commitButton: View {
    @Environment(\.presentationMode) var presentation
    
    
    var body: some View {
        Button(action: {
            self.presentation.wrappedValue.dismiss()
        }) {
            Text("Commit")
        }
    }
}
