import Firebase
import FirebaseFirestoreSwift
import Combine

class UserService: ObservableObject {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        Task {
            do {
                try await fetchCurrentUser()
            } catch {
                print("Failed to fetch current user: \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No user is logged in")
            return
        }
        
        let snapshot = try await Firestore.firestore().collection("user").document(uid).getDocument()
        
        do {
            let user = try snapshot.data(as: User.self)
            self.currentUser = user
            print("Debug: User is \(String(describing: user))")
        } catch {
            print("Error decoding user data: \(error.localizedDescription)")
        }
    }
    
    static func fetchUsers() async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await Firestore.firestore().collection("user").getDocuments()
        let users = snapshot.documents.compactMap({try? $0.data(as: User.self)})
        return users.filter({$0.id != currentUid})
    }
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("user").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    func reset() {
        self.currentUser = nil
    }
    
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("user").document(currentUid).updateData([
            "profileImageUrl": imageUrl
        ])
        self.currentUser?.profileImageUrl = imageUrl
    }
    
    func updateUserProfile(bio: String, link: String, isPrivateProfile: Bool) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("user").document(currentUid).updateData([
            "bio": bio,
            "link": link,
            "isPrivateProfile": isPrivateProfile
        ])
        self.currentUser?.bio = bio
        self.currentUser?.link = link
        self.currentUser?.isPrivateProfile = isPrivateProfile
    }
}
