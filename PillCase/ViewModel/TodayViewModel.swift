//
//  TodayViewModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 14.02.2023.
//

import Foundation
import CoreData
import SwiftUI
import Combine

class TodayViewModel: ObservableObject {
    
    // зарефакторить и убрать булианы

    @Published var todayPills: [Pill] = []

    @Published var morning: [Pill] = [] {
           didSet {
               isMorningEmpty = morning.isEmpty
           }
       }
       @Published var day: [Pill] = [] {
           didSet {
               isDayEmpty = day.isEmpty
           }
       }
       @Published var evening: [Pill] = [] {
           didSet {
               isEveningEmpty = evening.isEmpty
           }
       }
       @Published var night: [Pill] = [] {
           didSet {
               isNightEmpty = night.isEmpty
           }
       }
    @Published var isMorningEmpty = true
    @Published var isDayEmpty = true
    @Published var isEveningEmpty = true
    @Published var isNightEmpty = true
    
    
    let colors: [Color] = [CustomColor.firstCourse, CustomColor.secondCourse, CustomColor.thirdCourse, CustomColor.fourthCourse]
    
    private let calendar = Calendar.current

    func dateToInt(_ date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func getMonthName(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }


//     CoreData
    private let context: NSManagedObjectContext

     init() {
         self.context = CoreDataManager.shared.context
         fetchTodayPills()
         sortPillsByTimeOfDay()
     }

    func fetchTodayPills() {
        do {
            let pills = try context.fetch(Pill.fetchRequest())
            todayPills = pills.filter { Calendar.current.isDate($0.date!, inSameDayAs: Date()) }
            
        } catch {
            print("Failed to fetch today's pills: \(error)")
        }
    }
    

    // Sorting by time of day.

    func sortPillsByTimeOfDay() {
        for pill in todayPills {
               switch pill.timeOfDay {
               case "morning":
                   if !morning.contains(pill) {
                       morning.append(pill)
                   }
               case "day":
                   if !day.contains(pill) {
                       day.append(pill)
                   }
               case "evening":
                   if !evening.contains(pill) {
                       evening.append(pill)
                   }
               case "night":
                   if !night.contains(pill) {
                       night.append(pill)
                   }
               default:
                   break
               }
           }
       }
    
    func reload() {
        morning.removeAll()
        day.removeAll()
        evening.removeAll()
        night.removeAll()
        fetchTodayPills()
        sortPillsByTimeOfDay()
    }

    
    
  
    
    
    
    
    public func delete(_ pillId: UUID) {
        let fetchRequest: NSFetchRequest<Pill> = Pill.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", pillId.uuidString)
        do {
            let pill = try context.fetch(fetchRequest).first
            if let pillToDelete = pill {
                context.delete(pillToDelete)
                try context.save()
                
                // Update the data and refresh UI after deletion
                // Передалать под менее костыльную функцию
                reload()
                
            }
        } catch {
            print("Failed to delete pill: \(error)")
        }
    }

}
