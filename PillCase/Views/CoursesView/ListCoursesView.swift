//
//  ScrollCoursesView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 24.01.2023.
//

import SwiftUI

struct ListCoursesView: View {


    @ObservedObject var viewModel: CourseViewModel
    
    @EnvironmentObject var todayViewModel: TodayViewModel
    // test
    @EnvironmentObject var mainViewModel: MainViewModel
    
    let colors: [Color] = [CustomColor.firstCourse, CustomColor.secondCourse, CustomColor.thirdCourse, CustomColor.fourthCourse]
    
    var body: some View {
    
        if viewModel.courses.isEmpty {
            Text("Добавьте курс")
                .font(.system(size: 28, weight: .medium, design: .monospaced))
        } else {
            
            List {
                ForEach(viewModel.courses) { course in
                    CourseCardView(color: colors[course.courseColor], name: course.courseName, duration: course.douration, daysLeft: course.remainingDays, pillType: Image(course.type), dose: course.dose, unitOfMeasurement: course.unit, sumNumberOfPills: course.numberOfPills, intervalOfMedication: course.regimen, morning: course.morning, day: course.day, evening: course.evening, night: course.night)
                        .background(CustomColor.backGroundColor)
                        .listRowBackground(CustomColor.backGroundColor)
                        .listRowSeparator(.hidden)
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let courseToDelete = viewModel.courses[index].courseName
                        viewModel.deleteCourse(forCourse: courseToDelete)
                        // убрать в родительскую вьюмодель
                        mainViewModel.todayViewModel.reload()
                        mainViewModel.calendarViewModel.fetchData()
                    }
                }
                
                ////            if courses.count < 4 {
                ////                AddNewCourseSubView()
                ////                }
            }
            .background(CustomColor.backGroundColor)
            .listStyle(.plain)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollContentBackground(.hidden)
        }
     
        }
    
}

struct ScrollCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        ListCoursesView(viewModel: CourseViewModel())
    }
}


struct CourseCardView: View {
    var color: Color
    var name: String
    var duration: Int
    var daysLeft: Int
    var pillType: Image
    var dose: String
    var unitOfMeasurement: String
    var sumNumberOfPills: Int
    var intervalOfMedication: String
    var morning: Bool = false
    var day: Bool = false
    var evening: Bool = false
    var night: Bool = false
    

    
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
                    HStack(spacing: 0) {
                    
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
                                    .resizable()
                                        .frame(width: 32.0, height: 32.0)
                                    .foregroundColor(.white)
                                    
                            }
                        Circle()
                            .trim(from: 0, to: CGFloat(daysLeft)/CGFloat(duration))                                          .stroke(
                                color,
                                lineWidth: 13)
                            .frame(width: 59)
                            .rotationEffect(.degrees(-90))
                    }
                    
                    
                    VStack{
                        Text("Дней осталось: ")
                            .font(.system(size: 10, weight: .semibold, design: .default))
                            .fixedSize(horizontal: false, vertical: false)
                            .foregroundColor(.gray)
                        Text(String(daysLeft))
                            .font(.system(size: 46, weight: .bold, design: .default))
                    }
                }
                    .padding(.leading, 0)
                    .frame(width: 178)
                    Divider()
                        
                    
                        
                    HStack {
                        
                        HStack(spacing: 1){
                            VStack(spacing: 3){
                                
                                Image(systemName: "cross.vial.fill")
                                Image(systemName: "hockey.puck.fill")
                                Image(systemName: "timer.circle.fill")
                            }
                            .padding(.leading, 4)
                            .font(.system(size: 12))
                            .foregroundColor(color)
                            
                            VStack(alignment: .leading, spacing: 1) {
                                Text("\(dose) \(unitOfMeasurement)")
                                Text("\(sumNumberOfPills) р.")
                                Text(intervalOfMedication)
                            }
                            .font(.system(size: 12))
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        .font(.system(size: 10, weight: .light, design: .default))
                        .foregroundColor(.gray)
                        
                    
                        CourseDayView(morning: morning, day: day, evening: evening, night: night)
                            .padding(.trailing, 10)
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
