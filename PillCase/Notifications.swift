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
        content.title = "Take your medicine"
        content.sound = .default
        
        let calendar = Calendar.current
        
        // Group pills by course name
        let coursePills = Dictionary(grouping: pills, by: { $0.courseName })
        
        for courseName in coursePills.keys {
            // Filter pills by course name
            let coursePills = coursePills[courseName]!
            
            // Create pill names and fire dates arrays for the course
            var pillNames = [String]()
            var fireDates = [DateComponents]()
            
            for pill in coursePills {
                let startDateComponents = calendar.dateComponents([.year, .month, .day], from: pill.date!)
                let doseComponents = pill.timeOfDay == "morning" ? DateComponents(hour: 9) :
                                      pill.timeOfDay == "day" ? DateComponents(hour: 13) :
                                      pill.timeOfDay == "evening" ? DateComponents(hour: 17) :
                                      DateComponents(hour: 21)
                
                let fireDateComponents = DateComponents(calendar: calendar, timeZone: .current,
                                                         year: startDateComponents.year, month: startDateComponents.month, day: startDateComponents.day,
                                                         hour: doseComponents.hour, minute: doseComponents.minute)
                
                if let fireDate = fireDateComponents.date {
                    fireDates.append(fireDateComponents)
                }
            }
            
            // Create notification request for the course
            if !fireDates.isEmpty {
                pillNames.append(courseName!)
                content.body = "\(pillNames.joined(separator: ", "))"
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
