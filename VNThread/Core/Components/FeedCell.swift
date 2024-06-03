import SwiftUI

struct FeedCell: View {
    var thread: Thread
    @State private var isLiked = false
    @State private var likesCount: Int
    @State private var isShowingComments: Bool = false
    @State private var isShowingActionSheet = false
    @State private var isEditingCaption = false
    @State private var editedCaption = ""
    
    init(thread: Thread) {
        self.thread = thread
        self._likesCount = State(initialValue: thread.likes)
        self._editedCaption = State(initialValue: thread.caption)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                if let user = thread.user {
                    NavigationLink(destination: ProfileView(user: user)) {
                        CircularProfileImageView(user: user)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        if let user = thread.user {
                            NavigationLink(destination: ProfileView(user: user)) {
                                Text(user.username)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                        }
                        
                        Spacer()
                        
                        Text(thread.timestamp.timestampString())
                            .font(.caption)
                            .foregroundColor(Color(.systemGray3))
                        
                        Button {
                            isShowingActionSheet.toggle()
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }
                        .actionSheet(isPresented: $isShowingActionSheet) {
                            ActionSheet(
                                title: Text("Options"),
                                buttons: [
                                    .default(Text("Edit Caption"), action: {
                                        isEditingCaption = true
                                    }),
                                    .destructive(Text("Delete Thread"), action: {
                                        Task {
                                            do {
                                                try await ThreadService.deleteThread(thread)
                                            } catch {
                                                print("Error deleting thread: \(error)")
                                            }
                                        }
                                    }),
                                    .cancel()
                                ]
                            )
                        }
                    }
                    
                    if isEditingCaption {
                        TextField("Edit caption", text: $editedCaption, onCommit: {
                            Task {
                                do {
                                    try await ThreadService.updateCaption(for: thread, caption: editedCaption)
                                    isEditingCaption = false
                                } catch {
                                    print("Error updating caption: \(error)")
                                }
                            }
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(thread.caption)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                    }
                    
                    HStack(spacing: 16) {
                        HStack(spacing: 8) {
                            Button(action: {
                                isLiked.toggle()
                                
                                if isLiked {
                                    likesCount += 1
                                } else {
                                    likesCount -= 1
                                }
                                
                                Task {
                                    do {
                                        try await ThreadService.updateLikes(for: thread, likes: likesCount)
                                    } catch {
                                        print("Error updating likes: \(error)")
                                    }
                                }
                            }) {
                                Image(systemName: isLiked ? "heart.fill" : "heart")
                            }
                            Text("\(likesCount)")
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {
                            isShowingComments.toggle()
                        }) {
                            Image(systemName: "bubble")
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                }
            }
            Divider()
        }
        .padding()
        .alert(isPresented: $isShowingComments) {
            Alert(
                title: Text("Comments"),
                message: Text("Feature is being updated")
            )
        }
    }
}

#Preview {
    FeedCell(thread: DeveloperPreview.shared.thread)
}
