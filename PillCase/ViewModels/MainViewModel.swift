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
    @Published var todayPillsCount =  0
    
    
    
    func deletingReload() {
        todayViewModel.reload()
        calendarViewModel.fetchData()
        getTodayPillsCount()
    }
    
    func creationReload() {
        calendarViewModel.fetchData()
        todayViewModel.reload()
        getTodayPillsCount()
    }
    
    func getTodayPillsCount() {
        todayPillsCount = todayViewModel.todayPills.count
        UIApplication.shared.applicationIconBadgeNumber = todayViewModel.todayPills.count
    }
    
    func updateData() {
        todayViewModel.reload()
        getTodayPillsCount()
    }
     
    //MARK: Zoom
    var isZoomed: Bool {
        UIScreen.main.scale < UIScreen.main.nativeScale
        
    }
    
    func calculateZoomScale() -> CGFloat{
         print(UIScreen.main.scale)
         print(UIScreen.main.nativeScale)
         var result = UIScreen.main.scale/UIScreen.main.nativeScale
         print(result)
         return result
     }
    
}
