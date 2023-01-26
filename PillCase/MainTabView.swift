//
//  TabView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 19.01.2023.
//

import SwiftUI

#warning("Убрать скролл в другое вью с курсом, а на главном оставить только сегодняшний день, использовать заготовку с MedicationTimeView или оставить скролл но сделать его по принятиям, 4 карточки в них в приеме можно будет показывать иконку таблетки и добавить карточкам шапки в цвет секции")


struct MainTabView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            CoursesView()
                .tabItem {
                    Image(systemName: "pills.fill")
                    Text("Courses")
                }
            DetailDayView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
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
