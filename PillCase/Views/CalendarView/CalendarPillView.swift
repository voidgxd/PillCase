//
//  CalendarPillView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 06.03.2023.
//

import SwiftUI

struct CalendarPillView: View {
    @EnvironmentObject var dateHolder: DateHolder
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    
    @State private var isShowingSideMenu = false
    @State private var isRotated = false
    
    var body: some View {
        NavigationStack {
            ZStack {
            VStack(spacing: 1) {
                DateScrollerView()
                    .environmentObject(dateHolder)
                    .padding()
                    .frame(height: 84)
                
                dayOfWeekStack
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                    
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(CustomColor.backGroundColor)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill (
                                    .shadow(.inner(color:.black.opacity(0.45),radius: 1, x: 1, y: 1))
                                    .shadow(.inner(color: .white.opacity(0.60), radius: 1, x: -1, y: -1))
                                )
                                .foregroundColor(CustomColor.backGroundColor)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                        }
                    
                    calendarGrid
                        .padding(.horizontal, 4)
                        .padding(.vertical, 4)
                }
                .padding(.horizontal, 1)
                Divider()
            }
            .onTapGesture {
                withAnimation {
                    isShowingSideMenu = false
                }
            }
            .gesture(
                           DragGesture()
                               .onEnded { gesture in
                                   if gesture.translation.width < 0 || gesture.translation.height < 0 {
                                       // Swiped to the left or down
                                       self.nextMonth()
                                   } else if gesture.translation.width > 0 || gesture.translation.height > 0 {
                                       // Swiped to the left or up
                                       self.previousMonth()
                                   }
                               }
                       )
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
                    
                    Button(action: {
                        calendarViewModel.isShowingCourses.toggle()
                        withAnimation(.linear(duration: 1.0)) {
                            isRotated.toggle()
                        }
                    }) {
                        Image(systemName: calendarViewModel.isShowingCourses ? "calendar.circle" : "calendar.circle.fill")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(isRotated ? 360 : 0))
                    }
                }
            }
        }
    }
    
    var dayOfWeekStack: some View {
        HStack(spacing: 1) {
            Text("MON").dayOfWeek()
            Text("TUE").dayOfWeek()
            Text("WED").dayOfWeek()
            Text("THU").dayOfWeek()
            Text("FRI").dayOfWeek()
            Text("SAT").dayOfWeek()
                .foregroundColor(.red)
            Text("SUN").dayOfWeek()
                .foregroundColor(.red)
        }
        .font(.system(size: 18, weight: .thin, design: .rounded))
        
    }
    
    var calendarGrid: some View {
        VStack(spacing: 1) {
            
            let daysInMonth = CalendarHelper().daysInMonth(dateHolder.date)
            let firstDayOfMonth = CalendarHelper().firstOfMonth(dateHolder.date)
            let startingSpaces = CalendarHelper().weekDay(firstDayOfMonth)
            let prevMonth = CalendarHelper().minusMonth(dateHolder.date)
            let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)
            
            ForEach(0..<6) {
                row in
                    HStack(spacing: 1) {
                        ForEach(1..<8) {
                            column in
                            let count = column + (row * 7)
                            CalendarCell(count: count, startingSpaces:startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth)
                                .environmentObject(dateHolder)
                            
                        }
                    }
            }
        }
        .frame(maxHeight: .infinity)
    }
    
    public func previousMonth()
     {
         dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
     }
     
     public func nextMonth()
     {
         dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPillView()
    }
}


extension Text {
    func dayOfWeek() -> some View {
        self.frame(maxWidth: .infinity)
            .padding(.top, 1)
            .lineLimit(1)
    }
}
