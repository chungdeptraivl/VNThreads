//
//  CreateThreadViewModel.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import Foundation
import Firebase

class CreateThreadViewModel: ObservableObject {
    
    func uploadThread(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let thread = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: 0)
        
        try await ThreadService.uploadThread(thread)
    }
}
