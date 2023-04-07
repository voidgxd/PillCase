//
//  NewCourseViewModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 09.02.2023.
//

import Foundation
import SwiftUI
import CoreData


class CourseViewModel: ObservableObject {
    
    private let notificationManager = NotificationManager.shared
    
    @Published var pills: [Pill] = []
    
    @Published var courses: [Course] = []
    
    var isCoursesFull: Bool {
        return courses.count > 3
    }
    
    private let context: NSManagedObjectContext
    
    init() {
        self.context = CoreDataManager.shared.context
        fetchData()
        createCourses(from: pills)
    }
    
    private func fetchData() {
        do {
            pills = try context.fetch(Pill.fetchRequest())
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
    
    func createCourses(from pills: [Pill]){
        
        
        var coursesArray = [Course]()
        var courseDict = [String: [Pill]]()
        
        // Group pills by course name
        if !pills.isEmpty {
            for pill in pills {
                if let courseName = pill.courseName {
                    if courseDict[courseName] == nil {
                        courseDict[courseName] = [Pill]()
                    }
                    courseDict[courseName]?.append(pill)
                }
            }
            // Create a course for each group of pills
            for (courseName, coursePills) in courseDict {
                guard let firstPill = coursePills.sorted(by: { $0.date! < $1.date! }).first,
                      let lastPill = coursePills.sorted(by: { $0.date! > $1.date! }).first else {
                    continue
                }
                
                // Calculate remaining number of days
                
                func calculateRemainingDays(lastPillDate: Date) -> Int {
                    let today = Date()
                    let calendar = Calendar.current
                    
                    if calendar.isDate(today, inSameDayAs: lastPillDate) {
                        // If today is the same as the last pill date, return 0 days remaining
                        return 1
                    } else {
                        // Otherwise, calculate the number of days between today and the last pill date
                        let remainingDays = calendar.dateComponents([.day], from: today, to: lastPillDate).day! + 2
                        return remainingDays
                    }
                }
        
                let remainingDays = calculateRemainingDays(lastPillDate: lastPill.date!)
                
                // Determine dose schedule
                var morning = false
                var day = false
                var evening = false
                var night = false
                
                var numberOfPills = 0
                
                if coursePills.contains(where: { $0.timeOfDay == "morning" }) {
                    numberOfPills += 1
                    morning = true
                }
                if coursePills.contains(where: { $0.timeOfDay == "day" }) {
                    numberOfPills += 1
                    day = true
                }
                if coursePills.contains(where: { $0.timeOfDay == "evening" }) {
                    numberOfPills += 1
                    evening = true
                }
                if coursePills.contains(where: { $0.timeOfDay == "night" }) {
                    numberOfPills += 1
                    night = true
                }
                
                // Create the course
                let course = Course(courseColor: Int(firstPill.courseColor),
                                    courseName: courseName,
                                    startDate: firstPill.date!,
                                    endDate: lastPill.date!,
                                    dose: firstPill.dose!,
                                    morning: morning,
                                    day: day,
                                    evening: evening,
                                    night: night,
                                    type: firstPill.type!,
                                    unit: firstPill.unit!,
                                    remainingDays: remainingDays,
                                    regimen: firstPill.regimen!,
                                    numberOfPills: numberOfPills,
                                    douration: Int(firstPill.duration)
                )
                
                coursesArray.append(course)
            }
                courses = coursesArray
                objectWillChange.send()
            
            notificationManager.scheduleNotification(for: pills)
            
            debugPrint(courses)
            debugPrint(pills)
        }
    }
    
    func createPillCourse(courseName: String, color: Color, dose: String, type: String, unit: String, startDate: Date, selectedCourseDuration: Int, selectedRegimen: String, id: UUID, morning: Bool, day: Bool, evening: Bool, night: Bool) {
        
        var colorInt = 0
        
        switch color {
        case CustomColor.firstCourse:
            colorInt = 0
        case CustomColor.secondCourse:
            colorInt = 1
        case CustomColor.thirdCourse:
            colorInt = 2
        case CustomColor.fourthCourse:
            colorInt = 3
        default:
            colorInt = 0
        }
        
        
        var date = startDate
        for i in 0..<selectedCourseDuration+1 {
            switch selectedRegimen {
            case "every day":
                createPill(courseName: courseName, courseColor: colorInt, date: date, dose: dose, type: type, unit: unit, startDate: startDate, regimen: "every day", duration: selectedCourseDuration, morning: morning, day: day, evening: evening, night: night)
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            case "every other day":
                if i % 2 == 0 {
                    createPill(courseName: courseName, courseColor: colorInt, date: date, dose: dose, type: type, unit: unit, startDate: startDate, regimen: "every other day", duration: selectedCourseDuration, morning: morning, day: day, evening: evening, night: night)
                }
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            case "every 3 days":
                if i % 3 == 0 {
                    createPill(courseName: courseName, courseColor: colorInt, date: date, dose: dose, type: type, unit: unit, startDate: startDate, regimen: "every 3 days", duration: selectedCourseDuration, morning: morning, day: day, evening: evening, night: night)
                }
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            case "once a week":
                if i % 7 == 0 {
                    createPill(courseName: courseName, courseColor: colorInt, date: date, dose: dose, type: type, unit: unit, startDate: startDate, regimen: "once a week", duration: selectedCourseDuration, morning: morning, day: day, evening: evening, night: night)
                }
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            default:
                break
            }
        }
        fetchData()
        createCourses(from: pills)
        debugPrint(courses)
    }
    
    
    func createPill(
        courseName: String,
        courseColor: Int,
        date: Date,
        dose: String,
        id: UUID = UUID(),
        type: String,
        unit: String,
        startDate: Date,
        regimen: String,
        duration: Int,
        morning: Bool,
        day: Bool,
        evening: Bool,
        night: Bool
    ) {
        let timeOfDayOptions: [(String, Bool)] = [
            ("morning", morning),
            ("day", day),
            ("evening", evening),
            ("night", night)
        ]
        
        for (timeOfDay, isSelected) in timeOfDayOptions where isSelected {
            let pill = Pill(context: context)
            pill.courseName = courseName
            pill.courseColor = Int16(courseColor)
            pill.date = date
            pill.timeOfDay = timeOfDay
            pill.dose = dose
            pill.id = id
            pill.type = type
            pill.unit = unit
            pill.regimen = regimen
            pill.startDate = startDate
            pill.duration = Int16(duration)
            
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
    
    func deleteCourse(forCourse courseName: String) {
        let fetchRequest: NSFetchRequest<Pill> = Pill.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "courseName = %@", courseName)
        do {
            let pills = try context.fetch(fetchRequest)
            for pillToDelete in pills {
                context.delete(pillToDelete)
            }
            try context.save()
            courses.removeAll()
        } catch {
            print("Failed to delete pills: \(error)")
        }
        createCourses(from: pills)
    }
}
