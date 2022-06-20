//
//  Home.swift
//  SwiftUIFaceIDLogin
//
//  Created by ricardo silva on 26/04/2022.
//

import SwiftUI
import Firebase

struct Home: View {
    
    @AppStorage("login_status") var logStatus: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            if logStatus {
                Text("Logged In")
                Button("Logout") {
                    try? Auth.auth().signOut()
                    logStatus = false
                }

            } else {
                Text("Came as a Guest")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
