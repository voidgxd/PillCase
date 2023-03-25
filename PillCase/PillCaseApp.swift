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
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // for notifications
    
    let coreDataManager = CoreDataManager.shared
    let notificationManager = NotificationManager.shared
    let mainViewModel = MainViewModel()
//    let todayViewModel = TodayViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            
            MainTabView()
                .environment(\.managedObjectContext, coreDataManager.context)
                .environmentObject(mainViewModel)
                .onAppear {
                                checkOldPills()
                    notificationManager.requestAuthorization()
                            }
                .accentColor(Color(.label))
        }
        
    }

}

// for notifications
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        requestNotificationAuthorization()
//        return true
//    }
//}

