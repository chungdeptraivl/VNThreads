//
//  PreviewProvider.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = User(
        id: NSUUID().uuidString,
        fullname: "Thanh Chung Oi",
        email: "chung@gmail.com",
        username: "tconthemic",
        profileImageUrl: "https://example.com/profile.jpg",
        bio: "This is a bio",
        link: "https://example.com",
        isPrivateProfile: false
    )
    
    let thread = Thread(
        ownerUid: "123",
        caption: "Test caption",
        timestamp: Timestamp(),
        likes: 0)
}
