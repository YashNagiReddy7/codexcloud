import SwiftUI
import UserNotifications
import UIKit

final class AppNotificationDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    weak var navigationState: AppNavigationState?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        DispatchQueue.main.async {
            self.navigationState?.shouldShowTaskView = true
        }
        completionHandler()
    }
}

@main
struct WakeUpApp: App {
    @UIApplicationDelegateAdaptor(AppNotificationDelegate.self) private var appDelegate

    @StateObject private var alarmViewModel: AlarmViewModel
    @StateObject private var navigationState = AppNavigationState()

    private let notificationService: NotificationServicing

    init() {
        let notificationService = NotificationService()
        self.notificationService = notificationService
        _alarmViewModel = StateObject(
            wrappedValue: AlarmViewModel(notificationService: notificationService)
        )
    }

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: alarmViewModel)
                .environmentObject(navigationState)
                .onAppear {
                    appDelegate.navigationState = navigationState
                    notificationService.requestPermission()
                }
        }
    }
}
