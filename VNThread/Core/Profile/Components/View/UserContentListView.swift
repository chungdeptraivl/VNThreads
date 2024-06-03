import SwiftUI

struct UserContentListView: View {
    @StateObject var viewModel: UserContentListViewModel
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(ProfileThreadFilter.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: 180, height: 1)
                                .matchedGeometryEffect(id: "item", in: animation)
                        } else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 180, height: 1)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedFilter = filter
                            Task { await fetchFilteredThreads() }
                        }
                    }
                }
            }
            
            LazyVStack {
                ForEach(viewModel.threads) { thread in
                    FeedCell(thread: thread)
                }
            }
        }
    }
    
    @MainActor
    private func fetchFilteredThreads() async {
        do {
            switch selectedFilter {
            case .threads:
                try await viewModel.fetchUserThreads()
            case .likes:
                try await viewModel.fetchLikedThreads()
            }
        } catch {
            print("Error fetching threads: \(error.localizedDescription)")
        }
    }
}

#Preview {
    UserContentListView(user: DeveloperPreview.shared.user)
}
