//
//  TabView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 19.01.2023.
//

import SwiftUI

struct MainTabView: View {
    
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
                        Image(systemName: "hockey.puck.fill")
                        Text("Today")
                    }
                CoursesView().environmentObject(mainViewModel.courseViewModel)
                    .tabItem {
                        Image(systemName: "pills.fill")
                        Text("Courses")
                    }
                CalendarPillView()
                    .environmentObject(dateHolder)
                    .environmentObject(mainViewModel.calendarViewModel)
                    .tabItem {
                        Image(systemName: "calendar.badge.minus")
                        Text("Calendar")
                    }
            }
            .tint(CustomColor.nightShadow)
        }
    }
}
    
    struct MainTabView_Previews: PreviewProvider {
        static var previews: some View {
            MainTabView()
            
            
        }
    }


