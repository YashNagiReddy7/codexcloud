import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: AlarmViewModel
    @EnvironmentObject private var navigationState: AppNavigationState

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Wake Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(viewModel.alarm.isActive ? timeFormatter.string(from: viewModel.alarm.time) : "No alarm set")
                    .font(.title3)

                Text("Streak: \(viewModel.alarm.streak)")
                    .font(.headline)

                NavigationLink("Set Alarm") {
                    AlarmSetupView(viewModel: viewModel)
                }
                .buttonStyle(.borderedProminent)

                Button("Tasks") {
                    navigationState.shouldShowTaskView = true
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.center)
        }
        .fullScreenCover(isPresented: $navigationState.shouldShowTaskView) {
            TaskView {
                navigationState.shouldShowTaskView = false
            }
            .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    HomeView(viewModel: AlarmViewModel())
        .environmentObject(AppNavigationState())
}
