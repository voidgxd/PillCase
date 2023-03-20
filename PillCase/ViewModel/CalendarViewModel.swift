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
    
    #warning("add private to fechData")
    
     func fetchData() {
        pills.removeAll()
        do {
            pills = try context.fetch(Pill.fetchRequest())
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
    
//    func getDayPill(date: Date) -> CalendarDay {
//
//        var thisDayPills: [Pill] = []
//
//        var morning: [Pill] = []
//        var day: [Pill] = []
//        var evening: [Pill] = []
//        var night: [Pill] = []
//
//
//        func fetchThisDayPills(for date: Date) {
//            thisDayPills = pills.filter { Calendar.current.isDate($0.date!, inSameDayAs: date) }
//        }
//
//        fetchThisDayPills(for: date)
//
//
//
//        func sortPillsByTimeOfDay() {
//            for pill in thisDayPills {
//                   switch pill.timeOfDay {
//                   case "morning":
//                       if !morning.contains(pill) {
//                           morning.append(pill)
//                       }
//                   case "day":
//                       if !day.contains(pill) {
//                           day.append(pill)
//                       }
//                   case "evening":
//                       if !evening.contains(pill) {
//                           evening.append(pill)
//                       }
//                   case "night":
//                       if !night.contains(pill) {
//                           night.append(pill)
//                       }
//                   default:
//                       break
//                   }
//               }
//           }
//
//        sortPillsByTimeOfDay()
//
//        var calendarDay = CalendarDay(date: date, morningPills: morning.count, dayPills: day.count, eveningPills: evening.count, nightPills: night.count, courses: [])
//
//        // Get unique course names
//          let courseNames = Set(thisDayPills.map { $0.courseName })
//
//          // Create an array of CalendarCourse instances
//        var courses: [CalendarDay.CalendarCourse] = []
//          for courseName in courseNames {
//              if let pill = thisDayPills.filter({ $0.courseName == courseName }).first {
//                  let course = CalendarDay.CalendarCourse(courseName: courseName ?? "нет курса", coursePillType: pill.type!, courseColor: getColor(colorInt: Int(pill.courseColor)))
//                  courses.append(course)
//              }
//          }
//
//          // Return CalendarDay instance
//
//        print(calendarDay)
//          return calendarDay
//
//    }
    
    func getDayPill(date: Date) -> CalendarDay {
        var thisDayPills: [Pill] = []
        var morning: [Pill] = []
        var day: [Pill] = []
        var evening: [Pill] = []
        var night: [Pill] = []
        
        // Filter pills by date
        thisDayPills = pills.filter { Calendar.current.isDate($0.date!, inSameDayAs: date) }
        
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
                courseColor: getColor(colorInt: Int(coursePills.first?.courseColor ?? 0) ?? 0)
                
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
        
        return calendarDay
    }
    
    func getColor(colorInt :Int) -> Color {
        switch colorInt {
        case 0: return CustomColor.firstCourse
        case 1: return CustomColor.secondCourse
        case 3: return CustomColor.thirdCourse
        case 4: return CustomColor.fourthCourse
        default: return CustomColor.firstCourse
        }
    }
}
