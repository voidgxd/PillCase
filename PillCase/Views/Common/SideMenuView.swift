//
//  SideMenuView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 26.03.2023.
//

import SwiftUI

struct SideMenuView: View {

    var body: some View {
        NavigationView {
            VStack{
                VStack(alignment: .leading) {
                    HStack {
                        Image("sideMenuIcon")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .shadow(radius: 3)
                        Text("PillCase")
                    }
                    .padding([.top, .leading], 10)
                    Divider()
                    VStack(alignment: .leading) {
                        Text("FOR FEEDBACK")
                            .font(.system(size: 12, weight: .thin, design: .monospaced))
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(CustomColor.navigationBarColor)
                            Text("email@email.com")}
                    }
                    .padding(10)
                    Spacer()
                    VStack{
                        Divider()
                        Text("Made with 🧡 by Max Mosalev")
                            .font(.system(size: 10, weight: .thin, design: .monospaced))
                        
                    }
                    .padding(.bottom, 10)
                }
            }
            .background(CustomColor.backGroundColor)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
