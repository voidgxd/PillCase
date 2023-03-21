//
//  CalendarDayModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 17.03.2023.
//

import Foundation
import SwiftUI

struct CalendarDay {
    let date: Date
    
    let morningPills: Int
    let dayPills: Int
    let eveningPills: Int
    let nightPills: Int
    
    
//    let firstCourseColor: Color?
//    let secondCourseColor: Color?
//    let thirdCourseColor: Color?
//    let fourthCourseColor: Color?
//
//    let firstCoursePillType: String?
//    let secondCoursePillType: String?
//    let thirdCoursePilltype: String?
//    let fourthCoursePillType: String?
    
    let courses: [CalendarCourse]
    
    struct CalendarCourse: Identifiable {
        let courseName: String
        let coursePillType: String
        let courseColor: Color
        let id = UUID()
    }
}

extension CalendarDay.CalendarCourse: Equatable {
    static func ==(lhs: CalendarDay.CalendarCourse, rhs: CalendarDay.CalendarCourse) -> Bool {
        return lhs.courseName == rhs.courseName &&
               lhs.coursePillType == rhs.coursePillType &&
               lhs.courseColor == rhs.courseColor
    }
}
