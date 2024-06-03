//import Foundation
//import FirebaseFirestore
//
//class CommentService {
//    static let db = Firestore.firestore()
//    
//    static func addComment(_ comment: Comment, to thread: Thread) {
//        do {
//            let _ = try db.collection("threads").document(thread.id).collection("comments").addDocument(from: comment)
//        } catch {
//            print("Error adding comment: \(error.localizedDescription)")
//        }
//    }
//    
//    static func fetchComments(for thread: Thread, completion: @escaping ([Comment]) -> Void) {
//        db.collection("threads").document(thread.id).collection("comments").getDocuments { snapshot, error in
//            guard let snapshot = snapshot, error == nil else {
//                print("Error fetching comments: \(error?.localizedDescription ?? "Unknown error")")
//                completion([])
//                return
//            }
//            
//            let comments = snapshot.documents.compactMap { document -> Comment? in
//                try? document.data(as: Comment.self)
//            }
//            completion(comments)
//        }
//    }
//}
