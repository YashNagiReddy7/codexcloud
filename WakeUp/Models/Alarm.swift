import Foundation

struct Alarm: Codable {
    var time: Date
    var isActive: Bool
    var streak: Int

    static let `default` = Alarm(time: Date(), isActive: false, streak: 0)
}
