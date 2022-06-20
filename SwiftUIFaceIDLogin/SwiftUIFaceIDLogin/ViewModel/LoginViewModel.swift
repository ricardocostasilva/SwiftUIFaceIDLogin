//
//  LoginViewModel.swift
//  SwiftUIFaceIDLogin
//
//  Created by ricardo silva on 26/04/2022.
//

import SwiftUI
import Firebase
import LocalAuthentication
import SceneKit

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @AppStorage("use_face_id") var useFaceID: Bool = false
    @AppStorage("use_face_email") var faceIDEmail: String = ""
    @AppStorage("use_face_password") var faceIDPassword: String = ""
    
    
    @AppStorage("login_status") var logStatus: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorMsg: String = ""
    
    func loginUser(useFaceID: Bool, email: String = "", password: String = "") async throws {
        
        let _ = try await Auth.auth().signIn(withEmail: email != "" ? email : self.email, password: password != "" ? password : self.password)
        
        if useFaceID {
            self.useFaceID = useFaceID
            self.faceIDEmail = email
            self.faceIDPassword = password
        }
        
        DispatchQueue.main.async {
            self.logStatus = true
        }
        
    }
    
    func getBiometricStatus() -> Bool {
        
        let scanner = LAContext()
        
        return scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
    }
    
    func authenticateUser() async throws {
        
        let status = try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Login into the app")
        
        if status {
            try await loginUser(useFaceID: useFaceID, email: self.faceIDEmail, password: self.faceIDPassword)
        }
    }
    
}
