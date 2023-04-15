//
//  ScrollCurseView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 16.01.2023.
//

import SwiftUI

struct ScrollTodayView: View {
    
    @ObservedObject var viewModel: TodayViewModel
    
    var dateDay: Int
    var dateMonth : String
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20){
                    Spacer()
                    // morning
                    if !viewModel.morning.isEmpty {
                        TodayCardView(viewModel: viewModel, pillListOfSegment: viewModel.morning, timeOfDay: NSLocalizedString("Morning", comment: ""), headersColor: CustomColor.morning, dateDay: dateDay, dateMonth: dateMonth, morningNumberOfPills: viewModel.morning.count)
                            .onChange(of: viewModel.morning, perform: { _ in
                                
                                print("On receive")
                            })
                    } else {
                        
                    }
                    // day
                    if !viewModel.day.isEmpty {
                        TodayCardView(viewModel: viewModel, pillListOfSegment: viewModel.day, timeOfDay: NSLocalizedString("Day", comment: ""), headersColor: CustomColor.day, dateDay: dateDay, dateMonth: dateMonth, dayNumberOfPills: viewModel.day.count)
                    }
                    //                // evening
                    if !viewModel.evening.isEmpty {
                        TodayCardView(viewModel: viewModel, pillListOfSegment: viewModel.evening, timeOfDay: NSLocalizedString("Evening", comment: ""), headersColor: CustomColor.evening, dateDay: dateDay, dateMonth: dateMonth, eveningNumberOfPills: viewModel.evening.count)
                    }
                    //                // night
                    if !viewModel.night.isEmpty {
                        TodayCardView(viewModel: viewModel, pillListOfSegment: viewModel.night, timeOfDay: NSLocalizedString("Night", comment: ""), headersColor: CustomColor.night, dateDay: dateDay, dateMonth: dateMonth, nightNumberOfPIlls: viewModel.night.count)
                    }
                    Spacer()
                }
            }
            .frame(height: 180.scaled())
            
            .background(CustomColor.backGroundColor)
            
            // all empty
            if viewModel.morning.isEmpty && viewModel.day.isEmpty && viewModel.evening.isEmpty && viewModel.night.isEmpty {
                Text("No medications")
                    .font(.system(size: 28, weight: .ultraLight, design: .monospaced))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ScrollTodayView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollTodayView(viewModel: TodayViewModel(), dateDay: 1, dateMonth: "123")
    }
}

struct TodayCardView: View {
    
    var viewModel: TodayViewModel
    var pillListOfSegment: [Pill]
    var timeOfDay: String
    var headersColor: Color
    var dateDay: Int
    var dateMonth : String
    var morningNumberOfPills: Int = 0
    var dayNumberOfPills: Int = 0
    var eveningNumberOfPills: Int = 0
    var nightNumberOfPIlls: Int = 0
    
    
    var body: some View {
        ZStack {
            ZStack{
                RoundedRectangle(cornerRadius: 16.scaled())
                    .frame(width: 120.scaled(), height: 160.scaled())
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 4, y: 4)
                    .shadow(color: .white.opacity(0.99),  radius: 3, x: -4, y: -4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 13.scaled(), style: .continuous)
                            .fill (
                                .shadow(.inner(color: .white.opacity(0.10), radius: 20, x: 18, y: 8))
                            )
                            .foregroundColor(CustomColor.backGroundColor)
                    }
                Rectangle()
                    .frame(width: 120.scaled(), height: 20.scaled())
                    .cornerRadius(16, corners: [.topLeft, .topRight])
                    .foregroundColor(headersColor)
                    .position(x: 60.scaled(), y: 20.scaled())
            }
            
            VStack(alignment: .leading){
                
                VStack(spacing: 0) {
                    Spacer()
                    Text(timeOfDay)
                        .font(.system(size: 12, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 4.scaled())
                        .frame(height: 20.scaled(), alignment: .center)
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Text(dateMonth)
                                .font(.system(size: 8.scaled(), weight: .semibold, design: .default))
                                .foregroundColor(.gray)
                                .padding(0)
                            Text(String(dateDay))
                                .font(.system(size: 36, weight: .medium, design: .default))
                        }
                        .frame(width: 60.scaled())
                        
                        PillsDayView(morningNumberOfPills: morningNumberOfPills, dayNumberofPills: dayNumberOfPills, eveningNumberOfPills: eveningNumberOfPills, nightNumberOfPills: nightNumberOfPIlls)
                            .frame(width: 60.scaled())
                            .scaleEffect(UIScreen.isZoomed ? UIScreen.calculateZoomScale() : 1)
                    }
                    .frame(height: 60.scaled())
                    Spacer()
                }
                .padding(.top, 4.scaled())
                .frame(height: 80.scaled())
                .layoutPriority(1)
                
                VStack(spacing: 0) {
                    Divider()
                    
                    ForEach(pillListOfSegment, id: \.id) { pill in
                        HStack(spacing: 2) {
                            ZStack{
                                Circle()
                                    .frame(width: 16.scaled(), height: 16.scaled())
                                    .foregroundColor(getColor(colorInt: Int(pill.courseColor)))
                                Image(pill.type ?? "Pill1")
                                    .resizable()
                                    .frame(width: 13.scaled(), height: 13.scaled())
                            }
                            Text(pill.courseName ?? "")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                            
                            Spacer()
                            Text(String(pill.dose ?? ""))
                                .font(.system(size: 8, weight: .light, design: .default))
                                .frame(alignment: .trailing)
                            
                            
                            Text(NSLocalizedString(pill.unit ?? "", comment: ""))
                                .font(.system(size: 8, weight: .light, design: .default))
                                .frame(alignment: .trailing)
                        }
                        .font(.system(size: 14, weight: .light))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .padding([.leading, .trailing], 4.scaled())
                    }
                    .padding(.top, 2.scaled())
                    Spacer()
                }
                .frame(maxWidth: 120.scaled(), minHeight: 80.scaled(), maxHeight: 80.scaled())
            }
            .frame(width: 120.scaled(), height: 160.scaled())
        }
    }
}
