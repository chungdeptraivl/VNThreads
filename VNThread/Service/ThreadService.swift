//
//  ThreadService.swift
//  VNThread
//
//  Created by Apple on 5/30/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ThreadService {
    static func uploadThread(_ thread: Thread) async throws {
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore.firestore().collection("threads").addDocument(data: threadData)
    }
    
    static func fetchThreads() async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({try? $0.data(as: Thread.self)})
    }
    
    static func fetchUserThreads(uid: String) async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()
        
        let threads = snapshot.documents.compactMap({try? $0.data(as: Thread.self)})
        return threads.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
    
    static func updateLikes(for thread: Thread, likes: Int) async throws {
            guard let threadId = thread.threadId else { return }
            try await Firestore.firestore().collection("threads").document(threadId).updateData([
                "likes": likes
            ])
        }
    
    static func fetchLikedThreads(userId: String) async throws -> [Thread] {
            let snapshot = try await Firestore.firestore().collection("threads")
                .whereField("likedBy", arrayContains: userId)
                .getDocuments()
            
            return snapshot.documents.compactMap { try? $0.data(as: Thread.self) }
    }
    
    static func updateCaption(for thread: Thread, caption: String) async throws {
            guard let threadId = thread.threadId else { return }
            try await Firestore.firestore().collection("threads").document(threadId).updateData([
                "caption": caption
            ])
    }
        
        static func deleteThread(_ thread: Thread) async throws {
            guard let threadId = thread.threadId else { return }
            try await Firestore.firestore().collection("threads").document(threadId).delete()
    }
}
