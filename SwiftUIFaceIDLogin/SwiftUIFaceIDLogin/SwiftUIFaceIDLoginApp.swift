//
//  SwiftUIFaceIDLoginApp.swift
//  SwiftUIFaceIDLogin
//
//  Created by ricardo silva on 26/04/2022.
//

import SwiftUI
import Firebase

@main
struct SwiftUIFaceIDLoginApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
