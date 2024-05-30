//
//  LoginView.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            
            
            VStack {
                Spacer()
                
                Image("nike")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .padding()
                
                VStack {
                    TextField("Email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(ThreadTextFieldModifier())
                    
                    SecureField("Password", text: $viewModel.password)
                        .modifier(ThreadTextFieldModifier())
                }
                
                NavigationLink {
                    Text("Forgot password?")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Button {
                    Task{ try await viewModel.login() } 
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 348, height: 44)
                        .background(.black)
                        .cornerRadius(8)
                }
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.black)
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

#Preview {
    LoginView()
}
