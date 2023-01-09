//
//  ScrollCurseView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 16.01.2023.
//

import SwiftUI

struct ScrollCurseView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 10) {
                CourseDayView()
                CourseDayView()
                CourseDayView()
                CourseDayView()
                CourseDayView()
                CourseDayView()
                CourseDayView()
                
            }
        }

        
    }
}

struct ScrollCurseView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollCurseView()
    }
}
