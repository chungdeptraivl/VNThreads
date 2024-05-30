//
//  CircularProfileImageView.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import SwiftUI
import Kingfisher

struct CircularProfileImageView: View {
    var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        } else {
            Image("hyhy")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        }
    }
}

#Preview {
    CircularProfileImageView(user: DeveloperPreview.shared.user)
}
