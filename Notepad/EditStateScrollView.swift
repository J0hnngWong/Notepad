//
//  EditStateScrollView.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/10.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import SwiftUI

struct EditStateScrollView<Content: View>: View {
    
    @State var keyboardListener = KeyboardListener()
    private var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ScrollView {
            VStack{
                content
            }
        }
        .padding(.bottom, keyboardListener.currentHeight)
    }
}

struct EditStateScrollView_Previews: PreviewProvider {
    static var previews: some View {
        EditStateScrollView {
            Text("Hello edit scroll view")
        }
    }
}
