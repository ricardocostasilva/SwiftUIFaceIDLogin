//
//  ContentView.swift
//  SwiftUIFaceIDLogin
//
//  Created by ricardo silva on 26/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("login_status") var logStatus: Bool = false
    
    var body: some View {
        NavigationView {
            
            if logStatus {
                Home()
            } else {
                LoginPage()
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
