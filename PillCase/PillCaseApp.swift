//
//  PillCaseApp.swift
//  PillCase
//
//  Created by Максим Мосалёв on 06.01.2023.
//

import SwiftUI
import CoreData
import UIKit

@main
struct PillCaseApp: App {

    @Environment(\.scenePhase) var scenePhase
    let coreDataManager = CoreDataManager.shared
    let notificationManager = NotificationManager.shared
    let mainViewModel = MainViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            
            MainTabView()
                .environment(\.managedObjectContext, coreDataManager.context)
                .environmentObject(mainViewModel)
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        deleteExpiredPills(context: coreDataManager.context)
                        debugPrint("Active Main")
                    }
                }
                .onAppear {
                    notificationManager.requestAuthorization()
                            }

        }
        
    }

}



