//
//  NoteEditPage.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/4.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import SwiftUI

struct NoteEditPage: View {
    @Environment(\.presentationMode) var presentation
    
    @State var title: String
    @State var detail: String
    @ObservedObject var keyboardListener = KeyboardListener()
    @State var paddingValue: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                TextField("title", text: $title, onEditingChanged: { (value) in
                    
                }) {
                    
                }
                .foregroundColor(.black)
                .padding()
                TextField("detail", text: $detail, onEditingChanged: { (value) in
                    
                }) {
                    
                }
                .foregroundColor(.black)
                .padding()
                Button(action: {
//                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Commit")
                }
            }
        }
        .padding(.bottom, keyboardListener.currentHeight)
    }
}

struct NoteEditPage_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditPage(title: "title", detail: "detail")
    }
}
