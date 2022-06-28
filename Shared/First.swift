import SwiftUI

extension First {
    struct Props {
        @Binding var appeared: Bool
        let namespace: Namespace.ID
        let onNext: ()->()
    }
}
struct First: View {
    let props: Props
    @Binding var appeared: Bool
    @State private var appearedInternal: Bool = false

    var body: some View {
        VStack {
            HStack {Spacer()}
            Button("to Second", action: props.onNext)

            if appeared, appearedInternal {
                Text("FIRST PAGE (works fine)")
                        .font(.title2)
                        .transition(.move(edge: .leading))
            } else {
                Text(" ")
                        .font(.title2)
            }

            if props.appeared, appearedInternal {
                Text("FIRST PAGE (doesn't work on disappear)")
                        .font(.title2)
                        .transition(.move(edge: .leading))
            } else {
                Text(" ")
                        .font(.title2)
            }

            Spacer()

            RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.red)
                    .matchedGeometryEffect(
                            id: "Shape",
                            in: props.namespace,
                            isSource: true
                    )
                    .frame(width: 100, height: 100)

        }
                .onAppear { appearedInternal = true }
                .animation(.linear(duration: 1), value: appearedInternal)
    }
}
