//struct CommentView: View {
//    @ObservedObject var commentViewModel: CommentViewModel
//    @State private var newCommentText = ""
//    
//    var body: some View {
//        VStack {
//            List(commentViewModel.comments) { comment in
//                CommentRow(comment: comment)
//            }
//            
//            TextField("Add a comment...", text: $newCommentText)
//                .padding(.horizontal)
//            
//            Button(action: addComment) {
//                Text("Post")
//                    .padding(.horizontal)
//            }
//            .padding(.vertical)
//        }
//    }
//    
//    func addComment() {
//        commentViewModel.addComment(text: newCommentText)
//        newCommentText = ""
//    }
//}
