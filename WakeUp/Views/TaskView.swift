import SwiftUI

struct TaskView: View {
    @State private var isTaskCompleted = false
    let onTaskCompleted: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Complete task to stop alarm")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Button("Pushups Task") {
                completeTaskIfNeeded()
            }
            .buttonStyle(.borderedProminent)

            Button("Photo Task") {
                completeTaskIfNeeded()
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }

    private func completeTaskIfNeeded() {
        guard !isTaskCompleted else { return }
        isTaskCompleted = true
        onTaskCompleted()
    }
}

#Preview {
    TaskView(onTaskCompleted: {})
}
