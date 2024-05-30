//
//  CurrentUserProfileView.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    @State private var showActionSheet = false
    @State private var showEditProfile = false
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    ProfileHeaderView(user: currentUser, isCurrentUser: true)
                    
                    Button {
                        showEditProfile.toggle()
                    } label: {
                        Text("Edit profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(width: 352, height: 32)
                            .background(.white)
                            .cornerRadius(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }
                    
                    
                    if let user = currentUser {
                        UserContentListView(user: user)
                    }
                }
            }
            .sheet(isPresented: $showEditProfile, content: {
                if let user = currentUser {
                    EditProfileView(user: user)
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showActionSheet = true
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.black)
                    }
                }
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Setting options"),
                    buttons: [
                        .destructive(Text("Logout")) {
                            AuthService.shared.signOut()
                        },
                        .cancel()
                    ]
                )
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
