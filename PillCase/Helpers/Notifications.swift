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
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
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
        
        print("scheduleNotification called")
        
        removeAllScheduledNotifications()
        let content = UNMutableNotificationContent()
        content.title = "Take your medicine:"
        content.sound = .default
        
        let calendar = Calendar.current
        
        // Group pills by date and time of day
        var pillGroups = [String: [Pill]]()
        for pill in pills {
            guard let pillDate = pill.date else {
                // Skip pills with no date
                continue
            }
            
            let startDateComponents = calendar.dateComponents([.year, .month, .day], from: pillDate)
            let medicationTimes = pill.timeOfDay == "morning" ? DateComponents(hour: 9) :
                                  pill.timeOfDay == "day" ? DateComponents(hour: 13) :
                                  pill.timeOfDay == "evening" ? DateComponents(hour: 17) :
                                  DateComponents(hour: 21)
            
            let key = "\(startDateComponents.year!)-\(startDateComponents.month!)-\(startDateComponents.day!)-\(medicationTimes.hour!)"
            if pillGroups[key] == nil {
                pillGroups[key] = [pill]
            } else {
                pillGroups[key]?.append(pill)
            }
        }
        
        // Create notification requests for each group of pills
        for pillGroup in pillGroups.values {
            // Create pill names and fire date components arrays for the group
            var pillNames = [String]()
            var fireDateComponents = [DateComponents]()
            
            for pill in pillGroup {
                guard let pillDate = pill.date else {
                    // Skip pills with no date
                    continue
                }
                
                let startDateComponents = calendar.dateComponents([.year, .month, .day], from: pillDate)
                let medicationTimes = pill.timeOfDay == "morning" ? DateComponents(hour: 9) :
                                      pill.timeOfDay == "day" ? DateComponents(hour: 13) :
                                      pill.timeOfDay == "evening" ? DateComponents(hour: 17) :
                                      DateComponents(hour: 21)
                
                let fireDateComponent = DateComponents(calendar: calendar, timeZone: .current,
                                                         year: startDateComponents.year, month: startDateComponents.month, day: startDateComponents.day,
                                                         hour: medicationTimes.hour, minute: medicationTimes.minute)
                
                pillNames.append(pill.courseName!)
                fireDateComponents.append(fireDateComponent)
            }
            
            if !fireDateComponents.isEmpty {
                content.body = "\(pillNames.joined(separator: ", "))"
                let earliestFireDate = fireDateComponents.min()!
                let trigger = UNCalendarNotificationTrigger(dateMatching: earliestFireDate, repeats: false)
                let requestId = UUID().uuidString
                let request = UNNotificationRequest(identifier: requestId, content: content, trigger: trigger)
                
                notificationCenter.add(request) { (error) in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    } else {
//                        print(request)
//                        print("Notification scheduled successfully: \(request.identifier)")
                    }
                }
            }
        }
//        printAllScheduledNotifications()
    }
    
    func removeAllScheduledNotifications() {
            notificationCenter.removeAllPendingNotificationRequests()
        }
    
    func printAllScheduledNotifications() {
        notificationCenter.getPendingNotificationRequests { requests in
            for request in requests {
                print("Notification ID: \(request.identifier)")
                print("Notification Title: \(request.content.title)")
                print("Notification Body: \(request.content.body)")
                if let trigger = request.trigger as? UNCalendarNotificationTrigger {
                    let nextTriggerDate = trigger.nextTriggerDate()
                    print("Notification Fire Date: \(nextTriggerDate)")
                }
                print("------------------------------")
            }
        }
    }
   
}
