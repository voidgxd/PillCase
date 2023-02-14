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
    
    

    // CoreData
    private let context: NSManagedObjectContext
     
     init() {
         self.context = CoreDataManager.shared.context
         fetchTodayPills()
         sortPillsByTimeOfDay()
     }

    func fetchTodayPills() {
        let today = Date()
        let request: NSFetchRequest<Pill> = Pill.fetchRequest()
        request.predicate = NSPredicate(format: "date == %@", today as NSDate)
        
        do {
            let pills = try context.fetch(request)
            todayPills = pills
        } catch {
            print("Failed to fetch today's pills: \(error)")
        }
    }
    
    // Sorting by time of day.
    
    func sortPillsByTimeOfDay() {
         for pill in todayPills {
             switch pill.timeOfDay {
                 case "morning": morning.append(pill)
                 case "day": day.append(pill)
                 case "evening": evening.append(pill)
                 case "night": night.append(pill)
                 default: break
             }
         }
     }
    
    
}
