//
//  App Ext.swift
//  PillCase
//
//  Created by Максим Мосалёв on 16.03.2023.
//

import UIKit
import CoreData

extension PillCaseApp {
    
    func checkOldPills() {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: UNMutableNotificationContent(), trigger: trigger)
        UNUserNotificationCenter.current().add(request)

        // Call deleteExpiredPills() every day at 9:00 AM.
        let timer = Timer(fire: calendar.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .strict)!, interval: 86400, repeats: true) { _ in
            deleteExpiredPills(context: coreDataManager.context)
        }
        RunLoop.main.add(timer, forMode: .common)
    }
    
    func deleteExpiredPills(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Pill> = Pill.fetchRequest()
        let predicate = NSPredicate(format: "date < %@", Date() as NSDate)
        fetchRequest.predicate = predicate
        
        let expiredPills = try? context.fetch(fetchRequest)
        
        for pill in expiredPills ?? [] {
            context.delete(pill)
        }
        print("Called")
        try? context.save()
            mainViewModel.todayViewModel.fetchTodayPills()
        mainViewModel.deletingReload()
        
    }
}
