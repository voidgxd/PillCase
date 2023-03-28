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
//        var morning: [Pill] = []
//        var day: [Pill] = []
//        var evening: [Pill] = []
//        var night: [Pill] = []
//
//        // Filter pills by date
//        thisDayPills = pills.filter { Calendar.current.isDate($0.date!, inSameDayAs: date) }
//
//        // Sort pills by time of day
//        for pill in thisDayPills {
//            switch pill.timeOfDay {
//            case "morning":
//                if !morning.contains(pill) {
//                    morning.append(pill)
//                }
//            case "day":
//                if !day.contains(pill) {
//                    day.append(pill)
//                }
//            case "evening":
//                if !evening.contains(pill) {
//                    evening.append(pill)
//                }
//            case "night":
//                if !night.contains(pill) {
//                    night.append(pill)
//                }
//            default:
//                break
//            }
//        }
//
//        // Get unique course names
//        let courseNames = Set(thisDayPills.map { $0.courseName })
//
//        // Create an array of CalendarCourse instances
//        var courses: [(color: Color, type: String)] = []
//        for courseName in courseNames {
//            let coursePills = thisDayPills.filter({ $0.courseName == courseName })
//            let courseColor = getColor(colorInt: Int(coursePills.first?.courseColor ?? 0))
//            let courseType = coursePills.first?.type ?? ""
//            courses.append((courseColor, courseType))
//        }
//
//        // Create a CalendarDay instance
//        let calendarDay = CalendarDay(
//            date: date,
//            morningPills: morning.count,
//            dayPills: day.count,
//            eveningPills: evening.count,
//            nightPills: night.count,
//            firstCourseColor: courses.count >= 1 ? courses[0].color : nil,
//            secondCourseColor: courses.count >= 2 ? courses[1].color : nil,
//            thirdCourseColor: courses.count >= 3 ? courses[2].color : nil,
//            fourthCourseColor: courses.count >= 4 ? courses[3].color : nil,
//            firstCoursePillType: courses.count >= 1 ? courses[0].type : nil,
//            secondCoursePillType: courses.count >= 2 ? courses[1].type : nil,
//            thirdCoursePilltype: courses.count >= 3 ? courses[2].type : nil,
//            fourthCoursePillType: courses.count >= 4 ? courses[3].type : nil
//        )
//
//        return calendarDay
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
print(calendarDay)
        return calendarDay
    }
    
    
}
