//
//  RegistrationViewModel.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    @Published var username = ""
    
    
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email,
                                                password: password,
                                                fullname: fullname,
                                                username: username)
    }
}
