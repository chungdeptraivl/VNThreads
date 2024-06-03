//
//  ExploreView.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    @StateObject var viewModel = ExploreViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    if viewModel.filteredUsers.isEmpty {
                        Text("No results found") 
                            .padding()
                    } else {
                        ForEach(viewModel.filteredUsers) { user in
                            NavigationLink(value: user) {
                                VStack {
                                    UserCell(user: user)
                                    Divider()
                                }
                                .padding(.vertical)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: User.self, destination:{ user in ProfileView(user: user)})
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search ...")
            .onChange(of: searchText) { newValue in
                viewModel.filterUsers(with: newValue)
            }
        }
    }
}



#Preview {
    ExploreView()
}
