//
//  ScrollCoursesView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 24.01.2023.
//

import SwiftUI

struct ScrollCoursesView: View {
    var body: some View {
        CourseCardView(name: "Витамин Д", duration: 30, daysLeft: 23, pillType: (Image(systemName: "pill")), intervalOfMedication: "Через день")
    }
}

struct ScrollCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollCoursesView()
    }
}


struct CourseCardView: View {
    var name: String
    var duration: Int
    var daysLeft: Int
    var pillType: Image
    var intervalOfMedication: String
    var morningNumberOfPills: Int = 0
    var dayNumberOfPills: Int = 0
    var eveningNumberOfPills: Int = 0
    var nightNumberOfPIlls: Int = 0
    
    var body: some View {
        ZStack {
            MedicationTimeView(headerColor: .blue)
            VStack(alignment: .center, spacing: 0){
                Text(name)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .padding(5)
                    .foregroundColor(.white)
                    
                
                Spacer()
                HStack() {
                    
                    
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
                                    .foregroundColor(.blue)
                                
                                pillType
                                    .foregroundColor(.white)
                            }
                        Circle()
                            .trim(from: 0, to: 0.75)
                                          .stroke(
                                              Color.blue,
                                              lineWidth: 12)
                                          .frame(width: 59)
                                          .rotationEffect(.degrees(-90))
                    }
                    Spacer()
                }
                .padding(.horizontal, 10.0)
                Spacer()
            }
        }
        .frame(height: 120)
    }
}
