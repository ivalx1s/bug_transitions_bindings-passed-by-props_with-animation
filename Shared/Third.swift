import SwiftUI

extension Third {
    struct Props {
        let namespace: Namespace.ID
        let onNext: ()->()
    }
}
struct Third: View {
    let props: Props
    @Binding var appeared: Bool
    @State private var appearedInternal: Bool = false

    var body: some View {
        VStack {
            HStack {Spacer()}
            Button("to First", action: props.onNext)

            if appeared,
               appearedInternal {
                Text("THIRD PAGE")
                        .font(.title2)
                        .transition(.move(edge: .trailing))
            } else {
                Text(" ")
                        .font(.title2)
            }

            Rectangle()
                    .foregroundColor(.yellow)
                    .matchedGeometryEffect(
                            id: "Shape",
                            in: props.namespace,
                            isSource: true
                    )
                    .frame(width: 100, height: 200)

            Spacer()

        }
                .onAppear { appearedInternal = true }
                .animation(.linear(duration: 1), value: appearedInternal)
    }
}