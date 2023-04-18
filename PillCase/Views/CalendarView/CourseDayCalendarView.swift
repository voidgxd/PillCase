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

struct CourseDayCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDayCalendarView(calendarDay: CalendarDay(date: .now, morningPills: 2, dayPills: 2, eveningPills: 2, nightPills: 2, courses: [CalendarDay.CalendarCourse(courseName: "eee", coursePillType: "Pill1", courseColor: CustomColor.thirdCourse)]))
    }
}
