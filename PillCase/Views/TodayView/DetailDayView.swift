//
//  DetailDayView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 21.01.2023.
//

import SwiftUI

struct DetailDayView: View {
    
    var date: Date
    
    @ObservedObject var viewModel: DetailDayViewModel
    
    var morningArray: [Pill]
    var dayArray: [Pill]
    var eveningArray: [Pill]
    var nightArray: [Pill]
    
    init(date: Date, viewModel: DetailDayViewModel) {
        self.date = date
        self.viewModel = viewModel
        
        morningArray = viewModel.morning
        dayArray = viewModel.day
        eveningArray = viewModel.evening
        nightArray = viewModel.night
    }
    
    
    
    var body: some View {
        VStack(spacing: 0){
            VStack {
                
                Divider()
                DetailDayCardView(morningArray: morningArray, dayArray: dayArray, eveningArray: eveningArray, nightArray: nightArray, dateDay: viewModel.dateToInt(date), dateMonth: viewModel.getMonthName(from: date), dayOfTheWeek: viewModel.getDayOfWeek(from: date))
                Divider()
                
            }
            ZStack{
           
                
                
                ScrollView(showsIndicators: false){
                    if !morningArray.isEmpty {
                        DetalTimeOfTheDayView(timeOfTheDay: "Morning", headerColor: CustomColor.morning, pillListOfSegment: morningArray)
                        Divider()
                    }
                    if !dayArray.isEmpty {
                        DetalTimeOfTheDayView(timeOfTheDay: "Day", headerColor: CustomColor.day, pillListOfSegment: dayArray)
                        Divider()
                    }
                    if !eveningArray.isEmpty {
                        DetalTimeOfTheDayView(timeOfTheDay: "Evening", headerColor: CustomColor.evening, pillListOfSegment: eveningArray)
                        Divider()
                    }
                    if !nightArray.isEmpty {
                        DetalTimeOfTheDayView(timeOfTheDay: "Night", headerColor: CustomColor.night, pillListOfSegment: nightArray)
                    }
                    
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
        DetailDayView(date: .now, viewModel: DetailDayViewModel(date: .now))
    }
}

struct DetalTimeOfTheDayView: View {
    
    var timeOfTheDay: String = " "
    var headerColor: Color = CustomColor.morning
    var pillListOfSegment: [Pill]
    
    var colors: [Color] = [CustomColor.firstCourse, CustomColor.secondCourse, CustomColor.thirdCourse, CustomColor.fourthCourse]
    
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
                    .foregroundColor(headerColor)
                VStack{
                    Text(timeOfTheDay)
                        .padding(.top, 5)
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    VStack (alignment: .leading, spacing: 8){
                        ForEach(pillListOfSegment, id: \.id) { pill in
                            HStack(spacing: 6) {
                                ZStack{
                                    Circle()
                                        .frame(width: 22, height: 22)
                                        .foregroundColor(colors[Int(pill.courseColor)])
                                    Image(pill.type ?? "Pill1")
                                        .resizable()
                                        .frame(width: 19, height: 19)
                                }
                                Text(pill.courseName ?? "")
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                    
                                Spacer()
                                Text(String(pill.dose ?? ""))
                                    .font(.system(size: 16, weight: .light, design: .default))
                                    .frame(alignment: .trailing)
                                    
                                
                                Text(pill.unit ?? "")
                                    .font(.system(size: 16, weight: .light, design: .default))
                                    .frame(alignment: .trailing)
                                    
                                
                                
                                
                                
                            }
                                
                            }
                            .font(.system(size: 14, weight: .light))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .padding([.leading, .trailing], 4)
                            
                            
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
