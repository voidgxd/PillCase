//
//  TodayViewModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 14.02.2023.
//

import Foundation
import CoreData

class TodayViewModel: ObservableObject {

    @Published var todayPills: [Pill] = []

    @Published var morning: [Pill] = []
    @Published var day: [Pill] = []
    @Published var evening: [Pill] = []
    @Published var night: [Pill] = []

    private let calendar = Calendar.current

    func dateToInt(_ date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
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


}
