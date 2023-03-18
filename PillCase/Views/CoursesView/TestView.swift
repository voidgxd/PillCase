//
//  TestView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 09.02.2023.
//

import SwiftUI

struct TestView: View {
//    @ObservedObject var viewModel = TodayViewModel()
    @ObservedObject var viewModel = CourseViewModel()
    @ObservedObject var calendarViewModel = CalendarViewModel()
    
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
        
        
        var obj = calendarViewModel.getDayPill(date: .now)
        
        NavigationStack{
            VStack{
                Text(String(obj.morningPills))
                Text(String(obj.dayPills))
                Text(String(obj.eveningPills))
                Text(String(obj.nightPills))
            
            Button("Создать курс") {
                viewModel.createCourses(from: viewModel.pills)
                print(viewModel.courses)
                
            }
            Button("print") {
                print(viewModel.pills)
                
            }
        }
    
        }
        
        .navigationTitle("TEST")
        
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(viewModel: CourseViewModel())
    }
}
