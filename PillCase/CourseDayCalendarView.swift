//
//  CourseDayCalendarView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 17.03.2023.
//

import SwiftUI

struct CourseDayCalendarView: View {
    
    
    var firstCourseColor: Color?
    var secondCourseColor: Color?
    var thirdCourseColor: Color?
    var fourthCourseColor: Color?
    
    var firstCoursePillType: String?
    var secondCoursePillType: String?
    var thirdCoursePillType: String?
    var fourthCoursePillType: String?
    
    
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
            
                .frame(width: 46, height: 46)
                .foregroundColor(CustomColor.backGroundColor)
                .shadow(color: .black.opacity(0.2), radius: 2, x:3, y: 3)
                .shadow(color: .white.opacity(0.8),  radius: 2, x: -3, y: -3)
            
            VStack {
                VStack (spacing: 2){
                    HStack (spacing: 2) {
                        ZStack{
                            // morning
                            if firstCourseColor != nil {
                                Rectangle().cornerRadius(10, corners: .topLeft)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(firstCourseColor)
                                Image(firstCoursePillType!)
                                    .resizable()
                                    .frame(width: 16, height: 16)
                            }
                        }
                        ZStack{
                            // day
                            if secondCourseColor != nil {
                                Rectangle().cornerRadius(10, corners: .topRight)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(secondCourseColor)
                                Image(secondCoursePillType!)
                                    .resizable()
                                    .frame(width: 16, height: 16)
                            }
                                
                        }
                    }
                    HStack(spacing: 2) {
                        ZStack{
                            // night
                            if thirdCourseColor != nil {
                                Rectangle().cornerRadius(10, corners: .bottomLeft)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(thirdCourseColor)
                                Image(thirdCoursePillType!)
                                    .resizable()
                                    .frame(width: 16, height: 16)
                            }
                        }
                        ZStack{
                            // evening
                            if fourthCourseColor != nil {
                                Rectangle().cornerRadius(10, corners: .bottomRight)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(fourthCourseColor)
                                Image(fourthCoursePillType!)
                                    .resizable()
                                    .frame(width: 16, height: 16)
                            }
                        }
                    }
                }
            
            }
            
        }
    }
}

struct CourseDayCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDayCalendarView(firstCourseColor: CustomColor.firstCourse, secondCourseColor: CustomColor.secondCourse, thirdCourseColor: CustomColor.thirdCourse, fourthCourseColor: CustomColor.fourthCourse, firstCoursePillType: "Pill2", secondCoursePillType: "Pill4", thirdCoursePillType: "RoundPill2", fourthCoursePillType: "Syringe" )
    }
}
