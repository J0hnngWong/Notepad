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
}
