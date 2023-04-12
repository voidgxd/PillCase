//
//  CalendarViewModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 17.03.2023.
//

import Foundation
import CoreData
import SwiftUI

class CalendarViewModel: ObservableObject {
      
    @Published var isShowingCourses = true
  
    private let context: NSManagedObjectContext

     init() {
         self.context = CoreDataManager.shared.context
         fetchData()
     }
    
    @Published var pills: [Pill] = []
    
     func fetchData() {
        pills.removeAll()
        do {
            pills = try context.fetch(Pill.fetchRequest())
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
    
    
    func getDayPill(date: Date) -> CalendarDay {
        
        print ("getDayPill called")

        var thisDayPills: [Pill] = []
        var morning: [Pill] = []
        var day: [Pill] = []
        var evening: [Pill] = []
        var night: [Pill] = []

        // Filter pills by date
        thisDayPills = pills.filter {
            if let pillDate = $0.date {
                return Calendar.current.isDate(pillDate, inSameDayAs: date)
            } else {
                return false
            }
        }

        // Sort pills by time of day
        for pill in thisDayPills {
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

        // Get unique course names
        let courseNames = Set(thisDayPills.map { $0.courseName })

        // Create an array of CalendarCourse instances
        var courses: [CalendarDay.CalendarCourse] = []
        for courseName in courseNames {
            let coursePills = thisDayPills.filter({ $0.courseName == courseName })
            let course = CalendarDay.CalendarCourse(
                courseName: courseName ?? "нет курса",
                coursePillType: coursePills.first?.type ?? "",
                courseColor: getColor(colorInt: Int(coursePills.first?.courseColor ?? 0))
                
            )
            courses.append(course)
        }
        
        // Create a CalendarDay instance
        let calendarDay = CalendarDay(
            date: date,
            morningPills: morning.count,
            dayPills: day.count,
            eveningPills: evening.count,
            nightPills: night.count,
            courses: courses
        )
//        debugPrint(calendarDay)
        return calendarDay
    }
    

}
