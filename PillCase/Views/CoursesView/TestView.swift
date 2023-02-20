//
//  TestView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 09.02.2023.
//

import SwiftUI

struct TestView: View {
    @ObservedObject var viewModel = TodayViewModel()
    
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
                List {
                    ForEach(pills) { pill in
                        VStack{
                            HStack{
                                Text(dateFormatter.string(from: pill.date ?? Date.now))
                                Text(pill.courseName ?? "")
                                Text(pill.courseColor ?? "")
                            }
                        }
                    }
                }
                Button("Создать курс") {
                    viewModel.fetchTodayPills()
                    print(viewModel.todayPills.count)
                    
                }
            }
        }
        
        .navigationTitle("TEST")
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(viewModel: TodayViewModel())
    }
}
