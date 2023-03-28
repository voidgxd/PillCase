//
//  CoursesView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 26.01.2023.
//

import SwiftUI

struct CoursesView: View {
    
    @EnvironmentObject var todayViewModel: TodayViewModel
    @EnvironmentObject var courseViewModel: CourseViewModel
    
    @State private var isShowingSideMenu = false
    
    
    var body: some View {
        NavigationStack {
            
            ZStack{
                //                Divider()
                //                    .padding(.top, 20)
                //                ScrollCurseView()
                //                Spacer()
                //                Divider()
                
                VStack(spacing: 0) {
                    VStack{
                        ListCoursesView(viewModel: courseViewModel)
                    }
                    Spacer()
                    Divider()
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
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: NewCourseView(courseViewModel: courseViewModel)) {
                                                        Image(systemName: "plus").foregroundColor(.white
                                                        )
                                                        .font(.system(size: 22, weight: .bold))
                                                        .opacity(courseViewModel.isCoursesFull ? 0.2 : 1.0)
                                                    }
                            .disabled(courseViewModel.isCoursesFull)
                        }
                        
                    }
                    .onAppear{
                        self.courseViewModel.objectWillChange.send()
                    }
                    .background(CustomColor.backGroundColor)
            
        }
        
    }
    
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
