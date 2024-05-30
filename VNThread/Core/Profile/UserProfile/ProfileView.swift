import SwiftUI

struct ProfileView: View {
    let user: User
    @State private var showActionSheet = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                HStack(alignment: .top) {
                    ProfileHeaderView(user: user, isCurrentUser: false)
                }
                
                Button {
                    
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 32)
                        .background(.black)
                        .cornerRadius(8)
                }
                
                UserContentListView(user: user)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView(user: DeveloperPreview.shared.user)
}
