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
    
    
    func createPillCourse(courseName: String, dose: String, type: String, unit: String, startDate: Date, selectedCourseDuration: Int, selectedRegimen: String, id: UUID, morning: Bool, day: Bool, evening: Bool, night: Bool) {
        var date = startDate
        for i in 0..<selectedCourseDuration {
            switch selectedRegimen {
            case "каждый день":
                createPill(courseName: courseName, date: date, day: day, dose: dose, evening: evening, id: id, morning: morning, night: night, type: type, unit: unit, startDate: startDate)
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            case "через день":
                if i % 2 == 0 {
                    createPill(courseName: courseName, date: date, day: day, dose: dose, evening: evening, id: id, morning: morning, night: night, type: type, unit: unit, startDate: startDate)
                }
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            case "раз в 3 дня":
                if i % 3 == 0 {
                    createPill(courseName: courseName, date: date, day: day, dose: dose, evening: evening, id: id, morning: morning, night: night, type: type, unit: unit, startDate: startDate)
                }
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            case "раз в неделю":
                if i % 7 == 0 {
                    createPill(courseName: courseName, date: date, day: day, dose: dose, evening: evening, id: id, morning: morning, night: night, type: type, unit: unit, startDate: startDate)
                }
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            default:
                break
            }
        }
        
    }
    
    
//#warning("зарефакторить функцию")
    func createPill(courseName: String, date: Date, day: Bool, dose: String, evening: Bool, id: UUID, morning: Bool, night: Bool, type: String, unit: String, startDate: Date) {
        
      if morning {
        let pill = Pill(context: context)
        pill.courseName = courseName
        pill.date = date
        pill.timeOfDay = "morning"
        pill.dose = dose
        pill.id = UUID()
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

      if day {
        let pill = Pill(context: context)
        pill.courseName = courseName
        pill.date = date
        pill.timeOfDay = "day"
        pill.dose = dose
        pill.id = UUID()
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

      if evening {
        let pill = Pill(context: context)
        pill.courseName = courseName
        pill.date = date
        pill.timeOfDay = "evening"
        pill.dose = dose
        pill.id = UUID()
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

      if night {
        let pill = Pill(context: context)
        pill.courseName = courseName
        pill.date = date
        pill.timeOfDay = "night"
        pill.dose = dose
        pill.id = UUID()
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
        
    }
    
    func update() {
        
    }
    
    func delete() {
        
    }
    
}
