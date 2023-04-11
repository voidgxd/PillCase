//
//  MainViewModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 17.03.2023.
//

import Foundation
import CoreData
import SwiftUI

class MainViewModel: ObservableObject {
    
    
    @Published var todayViewModel = TodayViewModel()
    @Published var courseViewModel = CourseViewModel()
    @Published var calendarViewModel = CalendarViewModel()
    
    @Published var pills: [Pill] = []
    @Published var todayPillsCount =  0
    
    
    
    func deletingReload() {
        todayViewModel.reload()
        calendarViewModel.fetchData()
        getTodayPillsCount()
    }
    
    func creationReload() {
        calendarViewModel.fetchData()
        todayViewModel.reload()
        getTodayPillsCount()
    }
    
    func getTodayPillsCount() {
        todayPillsCount = todayViewModel.todayPills.count
        UIApplication.shared.applicationIconBadgeNumber = todayViewModel.todayPills.count
    }
    
    func updateData() {
        todayViewModel.reload()
        getTodayPillsCount()
    }
     
//    func deleteExpiredPills(context: NSManagedObjectContext) {
//
//        print("deleteExpiredPills called")
//
//        let fetchRequest: NSFetchRequest<Pill> = Pill.fetchRequest()
//        let calendar = Calendar.current
//        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
//        let predicate = NSPredicate(format: "date < %@", yesterday as NSDate)
//        fetchRequest.predicate = predicate
//
//        let expiredPills = try? context.fetch(fetchRequest)
//
//        for pill in expiredPills ?? [] {
//            context.delete(pill)
//        }
//
//        try? context.save()
////        mainViewModel.todayViewModel.fetchTodayPills()
////        mainViewModel.deletingReload()
//    }
    
//    func checkOldPills() {
//        let calendar = Calendar(identifier: .gregorian)
//        var dateComponents = DateComponents()
//        dateComponents.hour = 9
//        dateComponents.minute = 0
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: UNMutableNotificationContent(), trigger: trigger)
//        UNUserNotificationCenter.current().add(request)
//
//        // Call deleteExpiredPills() every day at 9:00 AM.
//        let timer = Timer(fire: calendar.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .strict)!, interval: 86400, repeats: true) { _ in
//            deleteExpiredPills(context: coreDataManager.context)
//        }
//        RunLoop.main.add(timer, forMode: .common)
//    }
    
}
