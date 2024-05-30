//
//  ExploreViewModel.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import Foundation


class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers()}
    }
    
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
    }
}
