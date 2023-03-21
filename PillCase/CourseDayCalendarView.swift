//
//  CourseDayCalendarView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 17.03.2023.
//

import SwiftUI

struct CourseDayCalendarView: View {
    let calendarDay: CalendarDay
    
    private let columns = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
    private let cellSize: CGFloat = 23.0
    
    var body: some View {
        
        
        let courses = calendarDay.courses.sorted(by: { $0.courseName < $1.courseName })
        
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 46, height: 46)
                .foregroundColor(CustomColor.backGroundColor)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 3, y: 3)
                .shadow(color: .white.opacity(0.8), radius: 2, x: -3, y: -3)
            LazyVGrid(columns: columns, alignment: .leading, spacing: 0) {
                ForEach(Array(courses.enumerated()), id: \.element.id) { index, course in
                        ZStack{
                            Rectangle().cornerRadius(10, corners: roundWhichCorner(position: index))
                                .frame(width: cellSize-1, height: cellSize-1)
                                .foregroundColor(course.courseColor)
                            
                            Image(course.coursePillType)
                                .resizable()
                                .frame(width: cellSize - 2, height: cellSize - 2)
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                
                
                
                
            }
            
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .padding(1)
        }
        .frame(width: 46, height: 46)
        
    }
}





    
    
    
//    let calendarDay: CalendarDay
//
//
//
//
//    var body: some View {
//
//        let courses = calendarDay.courses.sorted(by: { $0.courseName < $1.courseName })
//
//        ZStack {
//            RoundedRectangle(cornerRadius: 12)
//
//                .frame(width: 46, height: 46)
//                .foregroundColor(CustomColor.backGroundColor)
//                .shadow(color: .black.opacity(0.2), radius: 2, x:3, y: 3)
//                .shadow(color: .white.opacity(0.8),  radius: 2, x: -3, y: -3)
//
//
//
//
//            VStack {
//                VStack (spacing: 2){
//                    HStack (spacing: 2) {
//                        ZStack{
//                            // morning
//                            if courses.count > 0 {
//                                Rectangle().cornerRadius(10, corners: .topLeft)
//                                    .frame(width: 20, height: 20)
//                                    .foregroundColor(courses[0].courseColor)
//                                Image(courses[0].coursePillType)
//                                    .resizable()
//                                    .frame(width: 16, height: 16)
//                            } else {
//                                Rectangle().cornerRadius(10, corners: .topLeft)
//                                    .frame(width: 20, height: 20)
//                                    .opacity(0)
//                            }
//                        }
//                        ZStack{
//                            // day
//                            if courses.count > 1 {
//                                Rectangle().cornerRadius(10, corners: .topRight)
//                                    .frame(width: 20, height: 20)
//                                    .foregroundColor(courses[1].courseColor)
//                                Image(courses[1].coursePillType)
//                                    .resizable()
//                                    .frame(width: 16, height: 16)
//                            } else {
//                                Rectangle().cornerRadius(10, corners: .topLeft)
//                                    .frame(width: 20, height: 20)
//                                    .opacity(0)
//                            }
//
//                        }
//                    }
//                    HStack(spacing: 2) {
//                        ZStack{
//                            // night
//                            if courses.count > 2 {
//                                Rectangle().cornerRadius(10, corners: .bottomLeft)
//                                    .frame(width: 20, height: 20)
//                                    .foregroundColor(courses[2].courseColor)
//                                Image(courses[2].coursePillType)
//                                    .resizable()
//                                    .frame(width: 16, height: 16)
//                            } else {
//                                Rectangle().cornerRadius(10, corners: .topLeft)
//                                    .frame(width: 20, height: 20)
//                                    .opacity(0)
//                            }
//                        }
//                        ZStack{
//                            // evening
//                            if courses.count > 3 {
//                                Rectangle().cornerRadius(10, corners: .bottomRight)
//                                    .frame(width: 20, height: 20)
//                                    .foregroundColor(courses[3].courseColor)
//                                Image(courses[3].coursePillType)
//                                    .resizable()
//                                    .frame(width: 16, height: 16)
//                            } else {
//                                Rectangle().cornerRadius(10, corners: .topLeft)
//                                    .frame(width: 20, height: 20)
//                                    .opacity(0)
//                            }
//                        }
//                    }
//                }
//
//            }
//
//        }
//    }
//}

struct CourseDayCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDayCalendarView(calendarDay: CalendarDay(date: .now, morningPills: 2, dayPills: 2, eveningPills: 2, nightPills: 2, courses: [CalendarDay.CalendarCourse(courseName: "Ebala", coursePillType: "Pill1", courseColor: CustomColor.thirdCourse)]))
    }
}
