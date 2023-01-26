//
//  ScrollCoursesView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 24.01.2023.
//

import SwiftUI

struct ScrollCoursesView: View {
    // поменять на модель
    var courses:[String] = ["1", "2", "3"]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            CourseCardView(color: .blue, name: "Витамин Д", duration: 30, daysLeft: 23, pillType: (Image(systemName: "pill")), sumNumberOfPills: 4, intervalOfMedication: "через день")
            CourseCardView(color: .green, name: "Витамин Д", duration: 7, daysLeft: 2, pillType: (Image(systemName: "pill")), sumNumberOfPills: 4, intervalOfMedication: "через день")
            CourseCardView(color: .red, name: "Витамин Д", duration: 21, daysLeft: 18, pillType: (Image(systemName: "pill")), sumNumberOfPills: 4, intervalOfMedication: "через день")
           
            if courses.count < 4 {
                AddNewCourseSubView()
                }
            }
        .background(CustomColor.backGroundColor)
        }
    
}

struct ScrollCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollCoursesView()
    }
}


struct CourseCardView: View {
    var color: Color
    var name: String
    var duration: Int
    var daysLeft: Int
    var pillType: Image
    var sumNumberOfPills: Int
    var intervalOfMedication: String
    var morningNumberOfPills: Int = 0
    var dayNumberOfPills: Int = 0
    var eveningNumberOfPills: Int = 0
    var nightNumberOfPIlls: Int = 0
    
    var body: some View {
        ZStack {
            MedicationTimeView(headerColor: color)
            VStack(alignment: .center, spacing: 0){
                Text(name)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .padding(5)
                    .foregroundColor(.white)
                    
                
                Spacer()
                HStack(spacing: 0) {
                    HStack {
                    
                    ZStack{
                        
                        Circle()
                            .fill(
                                .shadow(.inner(color: .black.opacity(0.24),radius: 2, x:3, y: 3))
                                .shadow(.inner(color: .white, radius:2, x: -3, y: -3))
                            )
                            .overlay {
                                Circle()
                                    .frame(height: 55)
                                    .foregroundColor(CustomColor.backGroundColor)
                            }
                            .foregroundColor(CustomColor.backGroundColor)
                        
                        
                        
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 46, height: 46)
                            .foregroundColor(CustomColor.backGroundColor)
                            .shadow(color: .black.opacity(0.4), radius: 1, x:2, y: 2)
                            .shadow(color: .white.opacity(0.95),  radius: 1, x: -2, y: -2)
                            .overlay {
                                Circle()
                                    .frame(width: 42)
                                    .foregroundColor(color)
                                
                                pillType
                                    .foregroundColor(.white)
                            }
                        Circle()
                            .trim(from: 0, to: CGFloat(daysLeft)/CGFloat(duration))                                          .stroke(
                                color,
                                lineWidth: 12)
                            .frame(width: 59)
                            .rotationEffect(.degrees(-90))
                    }
                    
                    
                    VStack{
                        Text("Дней осталось: ")
                            .font(.system(size: 10, weight: .semibold, design: .default))
                            .foregroundColor(.gray)
                        Text(String(daysLeft))
                            .font(.system(size: 46, weight: .bold, design: .default))
                    }
                }
                    .padding(.leading)
                    .frame(width: 178)
                    Divider()
                    HStack {
                        HStack{
                            VStack{
                                Image(systemName: "cross.vial.fill")
                                Image(systemName: "number.circle.fill")
                                Image(systemName: "timer.circle.fill")
                            }
                            .font(.system(size: 12))
                            .foregroundColor(color)
                            VStack(alignment: .leading) {
                                Text("250 мг.")
                                Text("1 раз в день")
                                Text(intervalOfMedication)
                            }
                            .font(.system(size: 12))
                            
                        }
                        .padding(.leading, 0)
                        
                        .font(.system(size: 10, weight: .light, design: .default))
                        .foregroundColor(.gray)
                        CourseDayView(morningNumberOfPills: 1, dayNumberofPills: 0, eveningNumberOfPills: 2, nightNumberOfPills: 1)
                            .padding(.leading)
                    }
                    .frame(width: 178)
                }
                
                Spacer()
            }
        }
        .frame(width: 360 ,height: 120)
    }
}

struct AddNewCourseSubView: View {
    var body: some View {
        ZStack {
            MedicationTimeView(headerColor: .gray)
            VStack(alignment: .center, spacing: 0){
                Text("Новый курс")
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .padding(5)
                    .foregroundColor(.white)
                Spacer()
                HStack{
                    ZStack{
                        Circle()
                            .fill(
                                .shadow(.inner(color: .black.opacity(0.24),radius: 2, x:3, y: 3))
                                .shadow(.inner(color: .white, radius:2, x: -3, y: -3))
                            )
                            .overlay {
                                Circle()
                                    .frame(height: 55)
                                    .foregroundColor(CustomColor.backGroundColor)
                            }
                            .foregroundColor(CustomColor.backGroundColor)
                            .frame(width: 75)
                        
                        
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 46, height: 46)
                            .foregroundColor(CustomColor.backGroundColor)
                            .shadow(color: .black.opacity(0.4), radius: 1, x:2, y: 2)
                            .shadow(color: .white.opacity(0.95),  radius: 1, x: -2, y: -2)
                            .overlay {
                                Circle()
                                    .frame(width: 42)
                                    .foregroundColor(.gray)
                                
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                            }
                        Circle()
                            .trim(from: 0, to: 1.0)                                          .stroke(
                                .gray,
                                lineWidth: 12)
                            .frame(width: 59)
                            .rotationEffect(.degrees(-90))
                        
                    }
                    Spacer()
                }
                .padding(.leading, 34.0)
                Spacer()
            }
            
        }
    }
}
