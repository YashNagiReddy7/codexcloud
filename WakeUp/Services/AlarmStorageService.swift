import Foundation

protocol AlarmStorageServicing {
    func loadAlarm() -> Alarm
    func saveAlarm(_ alarm: Alarm)
}

final class AlarmStorageService: AlarmStorageServicing {
    private enum Keys {
        static let alarmTime = "alarm.time"
        static let isActive = "alarm.isActive"
        static let streak = "alarm.streak"
    }

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func loadAlarm() -> Alarm {
        let isActive = userDefaults.bool(forKey: Keys.isActive)
        let streak = userDefaults.integer(forKey: Keys.streak)

        guard let savedTime = userDefaults.object(forKey: Keys.alarmTime) as? Date else {
            return Alarm(time: Date(), isActive: isActive, streak: streak)
        }

        return Alarm(time: savedTime, isActive: isActive, streak: streak)
    }

    func saveAlarm(_ alarm: Alarm) {
        userDefaults.set(alarm.time, forKey: Keys.alarmTime)
        userDefaults.set(alarm.isActive, forKey: Keys.isActive)
        userDefaults.set(alarm.streak, forKey: Keys.streak)
    }
}
