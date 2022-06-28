import SwiftUI

extension ContentView {
    enum Page {
        case first
        case second
        case third
    }
}

struct ContentView: View {
    @State var page: Page = .first
    @Namespace var namespace
    private let pageTransition: AnyTransition = .asymmetric(
            insertion: .move(edge: .leading),
            removal: .move(edge: .trailing)
    )

    var body: some View {
        VStack {
            Text("MAIN CONTENT").padding()
            switch page {
            case .first: first
            case .second: second
            case .third: third
            }
        }
                .onChange(of: page) { page in
                    switchSubpagesAnimation(with: page)
                }
                .onAppear { switchSubpagesAnimation(with: page)}
    }

    private func switchSubpagesAnimation(with page: Page) {
        withAnimation(.linear(duration: 1)) {
            self.firstAppeared = page == .first
            self.secondAppeared = page == .second
            self.thirdAppeared = page == .third
        }
    }

    @State private var firstAppeared: Bool = false
    private var first: some View {
        First(
            props: .init(
                appeared: $firstAppeared,
                namespace: namespace,
                onNext: {setPage(.second)}
            ),
            appeared: $firstAppeared
        )
    }

    @State private var secondAppeared: Bool = false
    private var second: some View {
        Second(
            props: .init(
            namespace: namespace,
            onNext: {setPage(.third)}
        ),
            appeared: $secondAppeared
        )
    }

    @State private var thirdAppeared: Bool = false
    private var third: some View {
        Third(
                props: .init(
                        namespace: namespace,
                        onNext: {setPage(.first)}
                ),
                appeared: $thirdAppeared
        )
    }

    private func setPage(_ page: Page) {
        withAnimation(.linear(duration: 1)) {
            self.page = page
        }
    }
}


