//
//  TestView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 09.02.2023.
//

import SwiftUI

struct TestView: View {
//    @ObservedObject var viewModel = TodayViewModel()
    @ObservedObject var viewModel = NewCourseViewModel()
    
    let date = Date()
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            return formatter
        }()

    
// MARK: Возможный вариант
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pill.courseName, ascending: true)],
        animation: .default
    )
    private var pills: FetchedResults<Pill>
    
    
    var body: some View {
        NavigationStack{
            VStack{
                List(viewModel.courses) { course in
                    HStack {
                        Text(course.courseName)
                        Text(course.dose)
                        Text(course.unit)
                    // неправильно работает функция
                        Text(String(course.morning))
                        Text(String(course.day))
                        Text(String(course.evening))
                        Text(String(course.night))
                      
                    }
                      }
                Button("Создать курс") {
                    viewModel.createCourses(from: viewModel.pills)
                    print(viewModel.courses)
                    
                }
            }
        }
        
        .navigationTitle("TEST")
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(viewModel: NewCourseViewModel())
    }
}
