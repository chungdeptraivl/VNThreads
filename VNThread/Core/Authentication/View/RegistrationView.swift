//
//  RegistrationView.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image("think")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .padding()
            
            VStack {
                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .modifier(ThreadTextFieldModifier())
                
                TextField("Fullname", text: $viewModel.fullname)
                    .modifier(ThreadTextFieldModifier())
                
                TextField("Username", text: $viewModel.username)
                    .autocapitalization(.none)
                    .modifier(ThreadTextFieldModifier())
                
                SecureField("Password", text: $viewModel.password)
                    .modifier(ThreadTextFieldModifier())
            }
            
            Button {
                Task { try await viewModel.createUser()}
            } label: {
                Text("Register")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 348, height: 44)
                    .background(.black)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Aldready have an account?")
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    RegistrationView()
}
