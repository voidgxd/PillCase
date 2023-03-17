//
//  PillCaseApp.swift
//  PillCase
//
//  Created by Максим Мосалёв on 06.01.2023.
//

import SwiftUI
import CoreData

@main
struct PillCaseApp: App {
    
    let coreDataManager = CoreDataManager.shared
    
    let mainViewModel = MainViewModel()
//    let todayViewModel = TodayViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            
            MainTabView()
                .environment(\.managedObjectContext, coreDataManager.context)
                .environmentObject(mainViewModel)
                .onAppear {
                                checkOldPills()
                            }
        }
    }

}

