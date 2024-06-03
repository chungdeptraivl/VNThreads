import Foundation

class UserContentListViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        Task { try await fetchUserThreads() }
    }
    
    @MainActor
    func fetchUserThreads() async throws {
        var threads = try await ThreadService.fetchUserThreads(uid: user.id)
        
        for i in 0 ..< threads.count {
            threads[i].user = self.user
        }
        
        self.threads = threads
    }
    
    @MainActor
    func fetchLikedThreads() async throws {
        var likedThreads = try await ThreadService.fetchLikedThreads(userId: user.id)
        
        for i in 0 ..< likedThreads.count {
            let ownerUid = likedThreads[i].ownerUid
            likedThreads[i].user = try await UserService.fetchUser(withUid: ownerUid)
        }
        
        self.threads = likedThreads
    }
}
