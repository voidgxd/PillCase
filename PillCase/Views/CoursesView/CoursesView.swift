//
//  CoursesView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 26.01.2023.
//

import SwiftUI

struct CoursesView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var courseViewModel: CourseViewModel
    
    @State private var isShowingSideMenu = false

    var body: some View {
        NavigationStack {
            ZStack{
                VStack(spacing: 0) {
                    VStack{
                        ListCoursesView(viewModel: mainViewModel.courseViewModel)
                        
                    }
                    Spacer()
                    if UIScreen.isZoomed {
                        
                    } else {
                        Divider()
                    }
                }
                .onTapGesture {
                    withAnimation {
                        isShowingSideMenu = false
                    }
                }
                GeometryReader { _ in
                    HStack{
                        SideMenuView()
                            .offset(x: isShowingSideMenu ? 0 : -UIScreen.main.bounds.width)
                            .animation(.easeInOut(duration: 0.3), value: isShowingSideMenu)
                            .frame(width: 200)
                    }
                }
            }
            .background(CustomColor.backGroundColor)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(CustomColor.navigationBarColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingSideMenu.toggle()
                    } label: {
                        Image(systemName: "list.bullet").foregroundColor(.white
                        )
                        .font(.system(size: 22, weight: .bold))
                    }
                }
                ToolbarItem(placement: .principal) {
                    HStack {
                        
                        Text("PillCase")
                            .font(.custom("Futura", size: 22))
                            .foregroundColor(Color.white)
                            .shadow(color: Color.black.opacity(0.5), radius: 4, x: 1, y: 1)
                            .shadow(color: Color.white.opacity(0.5), radius: 4, x: -1, y: -1)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NewCourseView(courseViewModel: mainViewModel.courseViewModel)) {
                        Image(systemName: "plus").foregroundColor(.white
                        )
                        .font(.system(size: 22, weight: .bold))
                        .opacity(courseViewModel.isCoursesFull ? 0.2 : 1.0)
                    }
                    .disabled(courseViewModel.isCoursesFull)
                }
            }
            .onAppear{
                self.mainViewModel.courseViewModel.objectWillChange.send()
            }
            .background(CustomColor.backGroundColor)
        }
        
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
            .environmentObject(CourseViewModel())
    }
}
