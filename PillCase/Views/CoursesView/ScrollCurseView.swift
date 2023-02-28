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
            HStack(spacing: 20){
                Spacer()
                CurseCardView(month: "Декабрь", day: "01", morningNumberOfPills: 3, dayNumberofPills: 1, eveningNumberOfPills: 2, nightNumberOfPills: 1, image1: Image("Pill1"), image2: Image("Pill3"), image3: Image("RoundPill4"), course1: "Витамин Д", course2: "Актовегин", course3: "Омега 3")
                CurseCardView(month: "Декабрь", day: "02", morningNumberOfPills: 3, dayNumberofPills: 1, eveningNumberOfPills: 2, nightNumberOfPills: 1, image1: Image("Pill1"), image2: Image("Pill3"), image3: Image("RoundPill4"), course1: "Витамин Д", course2: "Актовегин", course3: "Омега 3")
                CurseCardView(month: "Декабрь", day: "03", morningNumberOfPills: 3, dayNumberofPills: 1, eveningNumberOfPills: 2, nightNumberOfPills: 1, image1: Image("Pill1"), image2: Image("Pill3"), image3: Image("RoundPill4"), course1: "Витамин Д", course2: "Актовегин", course3: "Омега 3")
                CurseCardView(month: "Декабрь", day: "04", morningNumberOfPills: 3, dayNumberofPills: 1, eveningNumberOfPills: 2, nightNumberOfPills: 1, image1: Image("Pill1"), image2: Image("Pill3"), image3: Image("RoundPill4"), course1: "Витамин Д", course2: "Актовегин", course3: "Омега 3")
           
                Spacer()
        
            }
        }
        .frame(height: 180)
        .background(CustomColor.backGroundColor)
        }

        
    
}

struct ScrollCurseView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollCurseView()
    }
}

struct CurseCardView: View {
    
    var month: String
    var day: String
    var morningNumberOfPills: Int = 0
    var dayNumberofPills: Int = 0
    var eveningNumberOfPills: Int = 0
    var nightNumberOfPills: Int = 0
    var image1: Image
    var image2: Image
    var image3: Image
    var course1: String
    var course2: String
    var course3: String
    
    
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            ZStack {
                
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 120, height: 160)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 4, y: 4)
                    .shadow(color: .white.opacity(0.99),  radius: 3, x: -4, y: -4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill (
                                .shadow(.inner(color: .white.opacity(0.10), radius: 20, x: 18, y: 8))
                            )
                            .foregroundColor(CustomColor.backGroundColor)
                            
                    }
                VStack{
                    HStack{
                        VStack {
                            Text(month)
                                .font(.system(size: 12, weight: .semibold, design: .default))
                                .foregroundColor(.gray)
                            Text(day)
                                .font(.system(size: 48, weight: .medium, design: .default))
                            Spacer()
                            
                        }
                        VStack{
                            PillsDayView(morningNumberOfPills: morningNumberOfPills, dayNumberofPills: dayNumberofPills, eveningNumberOfPills: eveningNumberOfPills, nightNumberOfPills: nightNumberOfPills)
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            
                        }
                        
                    }
                    Divider()
                    HStack(spacing: 4) {
                        VStack(spacing: 1) {
                            ZStack {
                                Circle()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(.blue)
                                
                                image1
                                    .resizable()
                                    .frame(width: 10, height: 10)
                                
                            }
                            
                            
                            ZStack {
                                Circle()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(.green)
                                
                                image2
                                    .resizable()
                                .frame(width: 10, height: 10)}
                            
                        
                            ZStack {
                                Circle()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(.red)
                                
                                image3
                                    .resizable()
                                    .frame(width: 10, height: 10)
                                
                            }
                        
                    }
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text(course1)
                            Text(course2)
                            Text(course3)
                        }
                        .padding(.leading, 0)
                    }
                    
                    
                    
                        
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 8, weight: .light, design: .default))
                    
                }
                .padding(5)
                
            }
            Spacer()
        }
    }
}
