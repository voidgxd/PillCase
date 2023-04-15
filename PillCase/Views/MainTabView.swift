//
//  TabView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 19.01.2023.
//

import SwiftUI

struct MainTabView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    let dateHolder = DateHolder()
    @State private var showOnboarding = !UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    
    
    var body: some View {
        if showOnboarding {
            OnboardingView(showOnboarding: $showOnboarding)
        } else {
            TabView {
                TodayView().environmentObject(mainViewModel.todayViewModel)
                    .tabItem {
                        Image(systemName: "pills.fill")
                        Text("Today")
                    }
                    .badge(mainViewModel.todayPillsCount)
                    
                CoursesView().environmentObject(mainViewModel.courseViewModel)
                    .tabItem {
                        Image(systemName: "cross.case.fill")
                        Text("Courses")
                    }
                CalendarPillView()
                    .environmentObject(dateHolder)
                    .environmentObject(mainViewModel.calendarViewModel)
                    .tabItem {
                        Image(systemName: "calendar")
                        
                        Text("Calendar")
                    }
                    
            }
            
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    mainViewModel.updateData()
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
            .tint(CustomColor.nightShadow)
        }
    }
        
}
    
    struct MainTabView_Previews: PreviewProvider {
        static var previews: some View {
            MainTabView().environmentObject(MainViewModel())
            
            
        }
    }


