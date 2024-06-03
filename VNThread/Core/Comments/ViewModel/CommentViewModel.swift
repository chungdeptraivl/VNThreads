//
//  CommentViewModel.swift
//  VNThread
//
//  Created by Apple on 5/31/24.
//

import Foundation

//struct CommentViewModel {
//    @Published var comments: [Comment] = []
//    let thread: Thread // Thread mà bình luận đang thuộc về
//    
//    init(thread: Thread) {
//        self.thread = thread
//        fetchComments()
//    }
//    
//    func fetchComments() {
//        CommentService.fetchComments(for: thread) { [weak self] fetchedComments in
//            self?.comments = fetchedComments
//        }
//    }
//    
//    func addComment(text: String) {
//        guard !text.isEmpty else { return }
//        let comment = Comment(text: text, userId: "currentUserId", timestamp: Date())
//        CommentService.addComment(comment, to: thread)
//    }
//}
