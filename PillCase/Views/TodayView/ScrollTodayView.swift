//
//  ScrollCurseView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 16.01.2023.
//

import SwiftUI

struct ScrollTodayView: View {
    var dateDay: Int
    var dateMonth : String
    var morningNumberOfPills: Int
    var dayNumberOfPills: Int
    var eveningNumberOfPills: Int
    var nightNumberOfPills: Int
    
    
    
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20){
                Spacer()
                // morning
                TodayCardView(timeOfDay: "Утро", colorOfHeader: CustomColor.morning, dateDay: dateDay, dateMonth: dateMonth, morningNumberOfPills: morningNumberOfPills)
                // day
                TodayCardView(timeOfDay: "День", colorOfHeader: CustomColor.day, dateDay: dateDay, dateMonth: dateMonth, dayNumberOfPills: dayNumberOfPills)
                // evening
                TodayCardView(timeOfDay: "Вечер", colorOfHeader: CustomColor.evening, dateDay: dateDay, dateMonth: dateMonth, eveningNumberOfPills: eveningNumberOfPills)
                // night
                TodayCardView(timeOfDay: "Ночь", colorOfHeader: CustomColor.night, dateDay: dateDay, dateMonth: dateMonth, nightNumberOfPIlls: nightNumberOfPills)
                Spacer()
        
            }
        }
        .frame(height: 160)
        .background(CustomColor.backGroundColor)
        }

        
    
}

struct ScrollTodayView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollTodayView(dateDay: 31, dateMonth: "Декабря", morningNumberOfPills: 2, dayNumberOfPills: 1, eveningNumberOfPills: 2, nightNumberOfPills: 1)
    }
}

struct TodayCardView: View {
    var timeOfDay: String
    var colorOfHeader: Color
    var dateDay: Int
    var dateMonth : String
    var morningNumberOfPills: Int = 0
    var dayNumberOfPills: Int = 0
    var eveningNumberOfPills: Int = 0
    var nightNumberOfPIlls: Int = 0
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 120, height: 140)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 4, y: 4)
                    .shadow(color: .white.opacity(0.99),  radius: 3, x: -4, y: -4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill (
                                .shadow(.inner(color: .white.opacity(0.10), radius: 20, x: 18, y: 8))
                            )
                            .foregroundColor(CustomColor.backGroundColor)
                            
                    }
                
                Rectangle()
                    .frame(width: 120, height: 20)
                    .cornerRadius(16, corners: [.topLeft, .topRight])
                    .foregroundColor(colorOfHeader)
                    .position(x: 60, y: 10)
                
                VStack{
                    Text(timeOfDay)
                        .font(.system(size: 12, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                        .padding(3)
                    HStack{
                        VStack {
                            Text(dateMonth)
                                .font(.system(size: 8, weight: .semibold, design: .default))
                                .foregroundColor(.gray)
                            Text(String(dateDay))
                                .font(.system(size: 36, weight: .medium, design: .default))
                            
                        }
                        
                            CourseDayView(morningNumberOfPills: morningNumberOfPills, dayNumberofPills: dayNumberOfPills, eveningNumberOfPills: eveningNumberOfPills, nightNumberOfPills: nightNumberOfPIlls)
                        
                    }
                    Spacer()
                    Divider()
                    ScrollView {
                        Text("Витамин Д 150мг - 3 р.")
                            .font(.system(size: 8, weight: .light, design: .default))
                        Text("Пенталгин 1шт - 2 р.")
                            .font(.system(size: 8, weight: .light, design: .default))
                        Text("Витамин Д 150мг - 3 р.")
                            .font(.system(size: 8, weight: .light, design: .default))
                        Text("Витамин Д 150мг - 3 р.")
                            .font(.system(size: 8, weight: .light, design: .default))
                    }
                    
                }
                
                
            }
            Spacer()
        }
    }
}
