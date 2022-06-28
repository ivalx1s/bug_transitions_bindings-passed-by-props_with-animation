import SwiftUI

extension Second {
    struct Props {
        let namespace: Namespace.ID
        let onNext: ()->()
    }
}
struct Second: View {
    let props: Props
    @Binding var appeared: Bool
    @State private var appearedInternal: Bool = false

    var body: some View {
        VStack {
            HStack {Spacer()}
            Button("to First", action: props.onNext)

            if appeared,
               appearedInternal {
                Text("SECOND PAGE")
                        .font(.title2)
                        .transition(.move(edge: .trailing))
            } else {
                Text(" ")
                        .font(.title2)
            }

            RoundedRectangle(cornerRadius: 100)
                    .foregroundColor(.blue)
                    .matchedGeometryEffect(
                            id: "Shape",
                            in: props.namespace,
                            isSource: true
                    )
                    .frame(width: 300, height: 300)

            Spacer()

        }
                .onAppear { appearedInternal = true }
                .animation(.linear(duration: 1), value: appearedInternal)
    }
}