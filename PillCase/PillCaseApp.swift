//
//  PillCaseApp.swift
//  PillCase
//
//  Created by Максим Мосалёв on 06.01.2023.
//

import SwiftUI

@main
struct PillCaseApp: App {
    
    let coreDataManager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView().environment(\.managedObjectContext, coreDataManager.context)
        }
    }
}
