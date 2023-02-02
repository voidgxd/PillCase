//
//  DetailDayView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 21.01.2023.
//

import SwiftUI

struct DetailDayView: View {
    var body: some View {
        VStack(spacing: 0){
            VStack {
                
                Divider()
                DetailDayCardView()
                Divider()
                
            }
            ZStack{
           
                
                
                ScrollView(showsIndicators: false){
                    DetalTimeOfTheDayView(timeOfTheDay: "Утро", color: CustomColor.morning)
                    Divider()
                    DetalTimeOfTheDayView(timeOfTheDay: "День", color: CustomColor.day)
                    Divider()
                    DetalTimeOfTheDayView(timeOfTheDay: "Вечер", color: CustomColor.evening)
                    Divider()
                    DetalTimeOfTheDayView(timeOfTheDay: "Ночь", color: CustomColor.night)
                    
                }
                

            }
            Divider()

            Spacer()
        }
        .background(CustomColor.backGroundColor)
    }
}

struct DetailDayView_Previews: PreviewProvider {
    static var previews: some View {
        DetailDayView()
    }
}

struct DetalTimeOfTheDayView: View {
    var timeOfTheDay: String = " "
    var color: Color = CustomColor.morning
    
    
    var body: some View {
        VStack {
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 16)
                
                    .frame(width: 320, height: 165)
                    .foregroundColor(CustomColor.backGroundColor)
                    .shadow(color: .black.opacity(0.3), radius: 2, x:3, y: 3)
                    .shadow(color: .white.opacity(0.5),  radius: 3, x: -6, y: -6)
                Rectangle()
                    .frame(width: 320, height: 30)
                    .cornerRadius(16, corners: [.topLeft, .topRight])
                    .foregroundColor(color)
                VStack{
                    Text(timeOfTheDay)
                        .padding(.top, 5)
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    VStack (alignment: .leading, spacing: 8){
                        HStack {
                            Image(systemName: "pill")
                            Text("Пенталгин 150 мг - 1 шт")
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "pill.fill")
                            Text("Пенталгин 150 мг - 1 шт")
                        }
                        HStack {
                            Image(systemName: "pill")
                            Text("Парацетамол 150 мг - 1 шт")
                        }
                        HStack {
                            Image(systemName: "pill")
                            Text("Пенталгин 150 мг - 1 шт")
                        }
                    }
                    .padding(.top, 5.0)
                    .padding([.trailing, .leading],  8)
                }
                
            }
            .frame(width: 320, height: 165)
            .padding(15)
            
        }
    }
}
