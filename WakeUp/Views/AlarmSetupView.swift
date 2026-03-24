import SwiftUI

struct AlarmSetupView: View {
    @ObservedObject var viewModel: AlarmViewModel
    @State private var selectedTime = Date()

    var body: some View {
        VStack(spacing: 24) {
            Text("Alarm Setup")
                .font(.title2)
                .fontWeight(.semibold)

            DatePicker(
                "Alarm Time",
                selection: $selectedTime,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.wheel)

            Button("Save Alarm") {
                viewModel.setAlarm(selectedTime)
            }
            .buttonStyle(.borderedProminent)

            Toggle("Alarm Active", isOn: Binding(
                get: { viewModel.alarm.isActive },
                set: { _ in viewModel.toggleAlarm() }
            ))
            .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    AlarmSetupView(viewModel: AlarmViewModel())
}
