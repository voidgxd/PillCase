//
//  TestView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 09.02.2023.
//

import SwiftUI

struct TestView: View {
//    @ObservedObject var viewModel: NewCourseViewModel
    
// MARK: Возможный вариант
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pill.courseName, ascending: true)],
        animation: .default
    )
    private var pills: FetchedResults<Pill>
    
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(pills) { pill in
                    VStack{
                        HStack{
                            Text(pill.courseName ?? "")
                            Text(pill.dose ?? "")
                            Text(pill.unit ?? "")
                        }
                    }
                }
            }
        }
        .navigationTitle("TEST")
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
