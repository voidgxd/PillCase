//
//  Extensions.swift
//  PillCase
//
//  Created by Максим Мосалёв on 22.02.2023.
//

import SwiftUI
import CoreData

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

//for notifications
extension Date {
    func string() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
extension DateComponents: Comparable {
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        let calendar = Calendar.current
        guard let lhsDate = calendar.date(from: lhs),
              let rhsDate = calendar.date(from: rhs) else {
            fatalError("Invalid date components")
        }
        return lhsDate < rhsDate
    }
}

extension PillCaseApp {
    func deleteExpiredPills(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Pill> = Pill.fetchRequest()
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
        let predicate = NSPredicate(format: "date < %@", yesterday as NSDate)
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

