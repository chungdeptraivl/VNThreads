//
//  ContentView.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ThreadTabView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
