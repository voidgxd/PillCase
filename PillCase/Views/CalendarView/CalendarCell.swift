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
    let count : Int
    let startingSpaces : Int
    let daysInMonth : Int
    let daysInPrevMonth : Int
    
   @State var isShowingCourses = true
    
    var body: some View {
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
                            CourseDayCalendarView(firstCourseColor: CustomColor.firstCourse, secondCourseColor: CustomColor.secondCourse, thirdCourseColor: CustomColor.thirdCourse, fourthCourseColor: CustomColor.fourthCourse, firstCoursePillType: "Pill3", secondCoursePillType: "Pill4", thirdCoursePillType: "RoundPill3", fourthCoursePillType: "Pill2")
                        } else {
                            PillsDayView(morningNumberOfPills: 3)
                            }
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
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
        CalendarCell(count: 1, startingSpaces: 1, daysInMonth: 1, daysInPrevMonth: 1)
    }
}
