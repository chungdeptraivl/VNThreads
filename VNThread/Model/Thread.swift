//
//  Thread.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct Thread: Identifiable, Codable, Hashable {
    @DocumentID var threadId: String?
    
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    
    var id: String {
        return threadId ?? NSUUID().uuidString
    }
    
    var user: User?
}
