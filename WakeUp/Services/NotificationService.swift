import Foundation
import UserNotifications

protocol NotificationServicing {
    func requestPermission()
    func scheduleAlarm(date: Date)
    func cancelAlarm()
}

final class NotificationService: NotificationServicing {
    private let center: UNUserNotificationCenter
    private let alarmIdentifier = "daily.alarm.notification"

    init(center: UNUserNotificationCenter = .current()) {
        self.center = center
    }

    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    func scheduleAlarm(date: Date) {
        cancelAlarm()

        let content = UNMutableNotificationContent()
        content.title = "Wake Up!"
        content.body = "Complete your task to stop the alarm"
        content.sound = .default

        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(
            identifier: alarmIdentifier,
            content: content,
            trigger: trigger
        )

        center.add(request)
    }

    func cancelAlarm() {
        center.removePendingNotificationRequests(withIdentifiers: [alarmIdentifier])
    }
}
