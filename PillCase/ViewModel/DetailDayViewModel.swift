//
//  DetailDayViewModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 22.02.2023.
//

import Foundation
import CoreData
import SwiftUI

class DetailDayViewModel: ObservableObject {

    @Published var todayPills: [Pill] = []

    @Published var morning: [Pill] = []
    @Published var day: [Pill] = []
    @Published var evening: [Pill] = []
    @Published var night: [Pill] = []
    
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
    
    func getDayOfWeek(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalizingFirstLetter()
    }
    
    
    
    private let context: NSManagedObjectContext
    
    init(date: Date) {
        self.context = CoreDataManager.shared.context
        fetchPills(for: date)
        sortPillsByTimeOfDay()
    }

    func fetchPills(for date: Date) {
        do {
            let pills = try context.fetch(Pill.fetchRequest())
            todayPills = pills.filter { Calendar.current.isDate($0.date!, inSameDayAs: date) }
        } catch {
            print("Failed to fetch pills: \(error)")
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
