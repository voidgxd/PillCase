//
//  CalendarCell.swift
//  PillCase
//
//  Created by Максим Мосалёв on 06.03.2023.
//

import SwiftUI

struct CalendarCell: View
{
    @EnvironmentObject var dateHolder: DateHolder
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    
    let count : Int
    let startingSpaces : Int
    let daysInMonth : Int
    let daysInPrevMonth : Int
    
    
   @State var isShowingCourses = false
    
    var date: Date? {
        let monthStruct = self.monthStruct()
        let components = Calendar.current.dateComponents([.year, .month], from: dateHolder.date)
        let year = components.year!
        let month = components.month!
        let day = monthStruct.dayInt
        switch monthStruct.monthType {
        case .Previous:
            return Calendar.current.date(from: DateComponents(year: month == 1 ? year - 1 : year, month: month == 1 ? 12 : month - 1, day: day))
        case .Current:
            return Calendar.current.date(from: DateComponents(year: year, month: month, day: day))
        case .Next:
            return Calendar.current.date(from: DateComponents(year: month == 12 ? year + 1 : year, month: month == 12 ? 1 : month + 1, day: day))
        }
    }
    
    @State var calendarDay = CalendarDay(date: .now, morningPills: 0, dayPills: 0, eveningPills: 0, nightPills: 0, courses: [])
    
    var body: some View {
        
        var calendarDay = calendarViewModel.getDayPill(date: date!)
        
        ZStack(alignment: .bottom){
          
            VStack(alignment: .center, spacing: 0){
                ZStack(alignment: .bottom){
                    
                    RoundedRectangle(cornerRadius: 16)
                    
                        .frame(maxWidth: .infinity, maxHeight: 72)
                        .foregroundColor(CustomColor.backGroundColor)
                    //                .shadow(color: .black.opacity(0.30), radius: 5, x: 9, y: 9)
                    //                .shadow(color: .white.opacity(1),  radius: 4, x: -9, y: -9)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill (
                                    .shadow(.inner(color:.black.opacity(0.45),radius: 2, x: 2, y: 2))
                                    .shadow(.inner(color: .white.opacity(0.60), radius: 2, x: -6, y: -6))
                                )
                                .foregroundColor(CustomColor.backGroundColor)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                        }
                    VStack(spacing: 0) {
                        HStack(alignment: .bottom) {
                            
                            Text(monthStruct().day())
                                .foregroundColor(textColor(type: monthStruct().monthType))
                            
                                                        }
                        if isShowingCourses {
//                            CourseDayCalendarView(firstCourseColor: calendarDay.courses[0].courseColor, secondCourseColor: calendarDay.courses[1].courseColor, thirdCourseColor: calendarDay.courses[2].courseColor, fourthCourseColor: calendarDay.courses[3].courseColor, firstCoursePillType: calendarDay.courses[0].coursePillType, secondCoursePillType: calendarDay.courses[1].coursePillType, thirdCoursePillType: calendarDay.courses[2].coursePillType, fourthCoursePillType: calendarDay.courses[3].coursePillType)
                        } else {
                            PillsDayView(morningNumberOfPills: calendarDay.morningPills, dayNumberofPills: calendarDay.dayPills, eveningNumberOfPills: calendarDay.eveningPills, nightNumberOfPills: calendarDay.nightPills)
                            
                            }
                        
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .onChange(of: calendarViewModel.dataChanged) { _ in
            calendarDay = calendarViewModel.getDayPill(date: date!)
        }
        
    }
    func textColor(type: MonthType) -> Color
    {
        return type == MonthType.Current ? Color.black : Color.gray
    }
    
    func monthStruct() -> MonthStruct
    {
        let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
        if(count <= start)
        {
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: MonthType.Previous, dayInt: day)
        }
        else if (count - start > daysInMonth)
        {
            let day = count - start - daysInMonth
            return MonthStruct(monthType: MonthType.Next, dayInt: day)
        }
        
        let day = count - start
        return MonthStruct(monthType: MonthType.Current, dayInt: day)
    }
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCell(count: 1, startingSpaces: 1, daysInMonth: 1, daysInPrevMonth: 1, calendarDay: CalendarDay(date: .now, morningPills: 1, dayPills: 1, eveningPills: 3, nightPills: 4, courses: []))
    }
}
