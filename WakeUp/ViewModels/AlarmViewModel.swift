import Foundation

final class AlarmViewModel: ObservableObject {
    @Published private(set) var alarm: Alarm

    private let storageService: AlarmStorageServicing
    private let notificationService: NotificationServicing

    init(
        storageService: AlarmStorageServicing = AlarmStorageService(),
        notificationService: NotificationServicing = NotificationService()
    ) {
        self.storageService = storageService
        self.notificationService = notificationService
        self.alarm = storageService.loadAlarm()
    }

    func setAlarm(_ time: Date) {
        alarm.time = time
        alarm.isActive = true
        persist()
        notificationService.scheduleAlarm(date: time)
    }

    func toggleAlarm() {
        alarm.isActive.toggle()
        persist()

        if alarm.isActive {
            notificationService.scheduleAlarm(date: alarm.time)
        } else {
            notificationService.cancelAlarm()
        }
    }

    func increaseStreak() {
        alarm.streak += 1
        persist()
    }

    private func persist() {
        storageService.saveAlarm(alarm)
    }
}
