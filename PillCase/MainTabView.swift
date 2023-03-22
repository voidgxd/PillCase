//
//  TabView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 19.01.2023.
//

import SwiftUI

#warning("Убрать скролл в другое вью с курсом, а на главном оставить только сегодняшний день, использовать заготовку с MedicationTimeView или оставить скролл но сделать его по принятиям, 4 карточки в них в приеме можно будет показывать иконку таблетки и добавить карточкам шапки в цвет секции")


struct MainTabView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
//    @EnvironmentObject var todayViewModel: TodayViewModel
    
    let dateHolder = DateHolder()
    
    var body: some View {
        TabView {
            TodayView().environmentObject(mainViewModel.todayViewModel)
                .tabItem {
                    Image(systemName: "hockey.puck.fill")
                    Text("Today")
                }
            CoursesView().environmentObject(mainViewModel.todayViewModel)
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
//            TestView(viewModel: mainViewModel.courseViewModel)
//                .tabItem {
//                    Image(systemName: "hockey.puck.fill")
//                    Text("Test")
//                }
        }
        .tint(CustomColor.nightShadow)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
           
        ScrollCurseView()
    }
}
