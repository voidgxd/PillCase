//
//  MainViewModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 17.03.2023.
//

import Foundation
import CoreData
import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var todayViewModel = TodayViewModel()
    @Published var courseViewModel = CourseViewModel()
    @Published var calendarViewModel = CalendarViewModel()
    
    @Published var pills: [Pill] = []
    
    func deletingReload() {
        todayViewModel.reload()
        calendarViewModel.fetchData()
    }
    
    func creationReload() {
        calendarViewModel.fetchData()
    }
    
}
