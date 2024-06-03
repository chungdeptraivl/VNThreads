import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    var user: User?
    var isCurrentUser: Bool
    
    init(user: User?, isCurrentUser: Bool) {
        self.user = user
        self.isCurrentUser = isCurrentUser
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 16) {
                if let imageUrl = user?.profileImageUrl {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                } else {
                    Image("hyhy")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user?.fullname ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(user?.username ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            if let bio = user?.bio {
                Text(bio)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
//            if let link = user?.link {
//                Link(destination: URL(string: link)!) {
//                    Text(link)
//                        .font(.footnote)
//                        .foregroundColor(.blue)
//                }
//            }
            
            if !isCurrentUser && (user?.isPrivateProfile ?? false) {
                Text("This account is private")
                    .font(.footnote)
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview {
    ProfileHeaderView(user: DeveloperPreview.shared.user, isCurrentUser: false)
}
