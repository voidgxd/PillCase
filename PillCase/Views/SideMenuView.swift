//
//  SideMenuView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 26.03.2023.
//

import SwiftUI

struct SideMenuView: View {
    let menuItems = ["Home", "Profile", "Settings"]

        var body: some View {
            NavigationView {
                List(menuItems, id: \.self) { item in
                    Text(item)
                }
                .listStyle(SidebarListStyle())
            }
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
            
        }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
