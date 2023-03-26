//
//  Notifications.swift
//  PillCase
//
//  Created by Максим Мосалёв on 23.03.2023.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private init() {}
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            } else if granted {
                print("Notification authorization granted.")
            } else {
                print("Notification authorization denied.")
            }
        }
    }
    
    func scheduleNotification(for pills: [Pill]) {
        removeAllScheduledNotifications()
        let content = UNMutableNotificationContent()
        content.title = "Take your medicine:"
        content.sound = .default
        
        let calendar = Calendar.current
        
        for timeOfDay in ["morning", "day", "evening", "night"] {
            var pillNamesSet = Set<String>()
            var fireDates = [DateComponents]()
            
            for pill in pills.filter({ $0.timeOfDay == timeOfDay }) {
                let startDateComponents = calendar.dateComponents([.year, .month, .day], from: pill.date!)
                let doseComponents: DateComponents
                switch pill.timeOfDay {
                case "morning":
                    doseComponents = DateComponents(hour: 9, minute: 0)
                case "day":
                    doseComponents = DateComponents(hour: 13, minute: 0)
                case "evening":
                    doseComponents = DateComponents(hour: 16, minute: 0)
                case "night":
                    doseComponents = DateComponents(hour: 20, minute: 0)
                default:
                    fatalError("Unexpected pill time of day")
                }
                
                let fireDateComponents = DateComponents(calendar: calendar, timeZone: .current,
                                                         year: startDateComponents.year, month: startDateComponents.month, day: startDateComponents.day,
                                                         hour: doseComponents.hour, minute: doseComponents.minute)
                
                if let fireDate = fireDateComponents.date {
                    pillNamesSet.insert(pill.courseName!)
                    fireDates.append(fireDateComponents)
                }
            }
            
            let pillNames = Array(pillNamesSet)
            
            if !pillNames.isEmpty {
                content.body = "Take your medicine: \(pillNames.joined(separator: ", "))"
                let triggerDates = fireDates.map { UNCalendarNotificationTrigger(dateMatching: $0, repeats: false) }
                
                let requestIds = triggerDates.enumerated().map { index, trigger in
                    return UUID().uuidString + String(index)
                }
                
                let requests = zip(requestIds, triggerDates).map { id, trigger in
                    return UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                }
                
                requests.forEach { request in
                    notificationCenter.add(request) { (error) in
                        if let error = error {
                            print("Error scheduling notification: \(error.localizedDescription)")
                        } else {
                            print(request)
                            print("Notification scheduled successfully: \(request.identifier)")
                        }
                    }
                }
            }
        }
    }
    
    func removeAllScheduledNotifications() {
            notificationCenter.removeAllPendingNotificationRequests()
        }
   
}
