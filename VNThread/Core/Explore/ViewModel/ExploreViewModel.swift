//
//  ExploreViewModel.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var filteredUsers = [User]() // Danh sách người dùng đã lọc
    
    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
        self.filteredUsers = self.users // Khởi tạo filteredUsers bằng danh sách người dùng ban đầu
    }
    
    // Phương thức để lọc danh sách người dùng dựa trên searchText
    func filterUsers(with searchText: String) {
        if searchText.isEmpty {
            self.filteredUsers = self.users // Nếu searchText rỗng, hiển thị lại danh sách người dùng ban đầu
        } else {
            self.filteredUsers = self.users.filter { user in
                return user.username.localizedCaseInsensitiveContains(searchText) || user.fullname.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
