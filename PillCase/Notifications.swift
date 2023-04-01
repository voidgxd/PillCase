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
            let pillsForTimeOfDay = pills.filter { $0.timeOfDay == timeOfDay }
            
            guard !pillsForTimeOfDay.isEmpty else {
                continue
            }
            
            var pillNames = Set<String>()
            var triggerDates = [DateComponents]()
            
            for pill in pillsForTimeOfDay {
                guard let pillDate = pill.date else {
                    continue
                }
                
                let pillComponents = calendar.dateComponents([.hour, .minute], from: pillDate)
                var doseComponents = DateComponents(hour: 0, minute: 0)
                
                switch pill.timeOfDay {
                case "morning":
                    doseComponents.hour = 9
                case "day":
                    doseComponents.hour = 13
                case "evening":
                    doseComponents.hour = 16
                case "night":
                    doseComponents.hour = 20
                default:
                    fatalError("Unexpected pill time of day")
                }
                
                let fireDateComponents = DateComponents(calendar: calendar,
                                                         year: pillComponents.year, month: pillComponents.month, day: pillComponents.day,
                                                         hour: doseComponents.hour, minute: doseComponents.minute)
                triggerDates.append(fireDateComponents)
                pillNames.insert(pill.courseName!)
            }
            
            let triggerDateSet = Set(triggerDates)
            guard triggerDateSet.count == triggerDates.count else {
                print("Duplicate notifications found for time of day \(timeOfDay)")
                continue
            }
            
            let notificationRequests = triggerDates.map { triggerDate -> UNNotificationRequest in
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                let requestId = UUID().uuidString
                return UNNotificationRequest(identifier: requestId, content: content, trigger: trigger)
            }
            
            notificationRequests.forEach { request in
                notificationCenter.add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    } else {
                        print(request)
                        print("Notification scheduled successfully: \(request.identifier)")
                    }
                }
            }
            
            let pillNamesString = Array(pillNames).joined(separator: ", ")
            print("Scheduled notifications for time of day \(timeOfDay) with pill names: \(pillNamesString)")
        }
    }
    
    func removeAllScheduledNotifications() {
            notificationCenter.removeAllPendingNotificationRequests()
        }
   
}
