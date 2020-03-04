//
//  UserData.swift
//  Landmarks
//
//  Created by 王嘉宁 on 2020/3/3.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
