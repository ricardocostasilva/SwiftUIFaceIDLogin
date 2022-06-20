//
//  LoginPage.swift
//  SwiftUIFaceIDLogin
//
//  Created by ricardo silva on 26/04/2022.
//

import SwiftUI

struct LoginPage: View {
    
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    
    @State var useFaceID: Bool = false
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.5)
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: -90))
                .hLeading()
                .offset(x:-23)
                .padding(.bottom, 30)
            
            Text("Hey, \n Login Now")
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .hLeading()
            
            TextField("Email", text: $loginViewModel.email)
                .keyboardType(.emailAddress)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginViewModel.email == "" ? Color.black.opacity(0.05) : Color.orange
                        )
                }
                .textInputAutocapitalization(.never)
                .padding(.top, 20)
            
            SecureField("Password", text: $loginViewModel.password)
                .textContentType(.password)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginViewModel.password == "" ? Color.black.opacity(0.05) : Color.orange
                        )
                }
                .textInputAutocapitalization(.never)
                .padding(.top, 15)
            
            if loginViewModel.getBiometricStatus() {
                Group {
                    if loginViewModel.useFaceID {
                        
                        Button {
                            Task {
                                do{
                                    try await loginViewModel.authenticateUser()
                                } catch {
                                    loginViewModel.errorMsg = error.localizedDescription
                                    loginViewModel.showError.toggle()
                                }
                            }
    
                        } label: {
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Label {
                                    Text("Use FaceID to login into previous account")
                                } icon: {
                                    Image(systemName: "faceid")
                                }
                                .font(.caption)
                                .foregroundColor(.gray)
                                
                                Text("Note: You can turn of it in settings")
                                    .font(.caption)
                                    .foregroundColor(.gray)

                            }
                        }
                        .hLeading()

                        
                    } else {
                        Toggle(isOn: $useFaceID) {
                            Text("Use FaceID to Login")
                                .foregroundColor(.gray)
                        }
                    }
                        
                }
                .padding(.vertical, 20)
            }
            
            Button {
                Task {
                    do{
                        try await loginViewModel.loginUser(useFaceID: useFaceID)
                    } catch {
                        loginViewModel.errorMsg = error.localizedDescription
                        loginViewModel.showError.toggle()
                    }
                }
            } label: {
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .hCenter()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.brown)
                    }
            }
            .padding(.vertical, 35)
            .disabled(loginViewModel.email == "" || loginViewModel.password == "")
            .opacity(loginViewModel.email == "" || loginViewModel.password == "" ? 0.5 : 1)
            
            NavigationLink {
                
            } label: {
                Text("Skip Now")
                    .foregroundColor(.gray)
            }


        }
        .padding(.horizontal, 25)
        .padding(.vertical)
        .alert(loginViewModel.errorMsg, isPresented: $loginViewModel.showError) {
            
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
