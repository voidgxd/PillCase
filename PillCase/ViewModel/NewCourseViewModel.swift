//
//  NewCourseViewModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 09.02.2023.
//

import Foundation
import CoreData


class NewCourseViewModel: ObservableObject {
    
    
    
   @Published var pills: [Pill] = []
    
    private let context: NSManagedObjectContext

    init() {
      self.context = CoreDataManager.shared.context
      fetchData()
    }

    private func fetchData() {
      do {
        pills = try context.fetch(Pill.fetchRequest())
      } catch {
        print("Failed to fetch items: \(error)")
      }
    }
    
    
    func createPill(courseName: String, date: Date, day: Bool, dose: String, evening: Bool, id: UUID, morning: Bool, night: Bool, quantity: Int, type: String, unit: String) {
        let pill = Pill(context: context)
        pill.courseName = courseName
        pill.date = date
        pill.day = day
        pill.dose = dose
        pill.evening = evening
        pill.id = id
        pill.morning = morning
        pill.night = night
        pill.quantity = Int16(quantity)
        pill.type = type
        pill.unit = unit

        do {
            try self.context.save()
            DispatchQueue.main.async {
                  self.pills.append(pill)
                }
        } catch {
          print("Failed to save pill: \(error)")
        }
      }
    
    func update() {
        
    }
    
}
