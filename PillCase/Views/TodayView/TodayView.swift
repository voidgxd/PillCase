//
//  Case.swift
//  PillCase
//
//  Created by Максим Мосалёв on 07.01.2023.
//

import SwiftUI

struct TodayView: View {
    
    @EnvironmentObject var todayViewModel: TodayViewModel
    @StateObject private var detailViewModel = DetailDayViewModel(date: Date())
    
    @State private var isShowingSideMenu = false
    @State private var isShowingDetail = false
    
    var body: some View {
        NavigationStack {
            ZStack {
            VStack {
                Divider()
                    .padding(.top, 20)
                ScrollTodayView(viewModel: todayViewModel, dateDay: todayViewModel.dateToInt(.now), dateMonth: todayViewModel.getMonthName(from: .now))
                Divider()
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 35)
                    
                        .frame(width: 296, height: 296)
                        .foregroundColor(CustomColor.backGroundColor)
                        .shadow(color: .black.opacity(0.30), radius: 5, x: 9, y: 9)
                        .shadow(color: .white.opacity(1),  radius: 4, x: -9, y: -9)
                    
                    VStack {
                        VStack (spacing: 0) {
                            
                            HStack (spacing: 0) {
                                ZStack {
                                    SegmentView(color: CustomColor.morning, secondColor: CustomColor.morningSecond, shadowColor: CustomColor.morningShadow, degrees: 0, letter: "M", isEmpty: todayViewModel.isMorningEmpty)
                                        .overlay {
                                            LetterView(color: CustomColor.morning, shadowColor: CustomColor.morningShadow, letter: "M", degrees: 0, positionX: 142.5, positionY: 142)
                                        }
                                    PillsOfSegmentView(viewModel: todayViewModel, pillsTimeOfDay: todayViewModel.morning)
                                }
                                
                                ZStack {
                                    SegmentView(color: CustomColor.day, secondColor: CustomColor.daySecond, shadowColor: CustomColor.dayShadow, degrees: 90, letter: "D", isEmpty: todayViewModel.isDayEmpty)
                                        .overlay {
                                            LetterView(color: CustomColor.day, shadowColor: CustomColor.dayShadow, letter: "D", degrees: 0, positionX: 7.5, positionY: 142)
                                        }
                                    PillsOfSegmentView(viewModel: todayViewModel, pillsTimeOfDay: todayViewModel.day)
                                }
                                
                            }
                            HStack (spacing: 0) {
                                ZStack{
                                    SegmentView(color: CustomColor.night, secondColor: CustomColor.nightSecond, shadowColor: CustomColor.nightShadow, degrees: -90, letter: "N", isEmpty: todayViewModel.isNightEmpty)
                                        .overlay {
                                            LetterView(color: CustomColor.night, shadowColor: CustomColor.nightShadow, letter: "N", degrees: 0, positionX: 142.5, positionY: 8)
                                        }
                                    PillsOfSegmentView(viewModel: todayViewModel, pillsTimeOfDay: todayViewModel.night)
                                }
                                ZStack {
                                    SegmentView(color: CustomColor.evening, secondColor: CustomColor.eveningSecond, shadowColor: CustomColor.eveningShadow, degrees: 180, letter: "E", isEmpty: todayViewModel.isEveningEmpty)
                                        .overlay {
                                            LetterView(color: CustomColor.evening, shadowColor: CustomColor.eveningShadow, letter: "E", degrees: 0, positionX: 7.5, positionY: 8)
                                        }
                                    PillsOfSegmentView(viewModel: todayViewModel, pillsTimeOfDay: todayViewModel.evening)
                                }
                            }
                        }
                    }
                }
                .fixedSize(horizontal: false, vertical: false)
                
                Spacer()
                Spacer()
                Divider()
            }
            .onTapGesture {
                withAnimation {
                    isShowingSideMenu = false
                }
            }
                GeometryReader { _ in
                    ZStack{
                        
                        
                        HStack {
                            SideMenuView()
                                .offset(x: isShowingSideMenu ? 0 : -UIScreen.main.bounds.width)
                                .animation(.easeInOut(duration: 0.3), value: isShowingSideMenu)
                                .frame(width: 200)
                        }
                    }
                }
        }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(CustomColor.navigationBarColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingSideMenu.toggle()
                    } label: {
                        Image(systemName: "list.bullet").foregroundColor(.white
                        )
                        .font(.system(size: 22, weight: .bold))
                    }
                }
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("PillCase")
                            .font(.custom("Futura", size: 22))
                            .foregroundColor(Color.white)
                            .shadow(color: Color.black.opacity(0.5), radius: 4, x: 1, y: 1)
                            .shadow(color: Color.white.opacity(0.5), radius: 4, x: -1, y: -1)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        self.isShowingDetail = true
                    } label: {
                        
                            Image(systemName: "pills.circle").foregroundColor(.white
                            )
                            .font(.system(size: 22, weight: .bold))
                        }
                    .sheet(isPresented: $isShowingDetail) {
                        DetailDayView(date: .now, viewModel: DetailDayViewModel(date: .now))
                                    }
                }
            }
            .onAppear {
                        todayViewModel.fetchTodayPills()
                        todayViewModel.sortPillsByTimeOfDay()
                    }
            .background(CustomColor.backGroundColor)
        }
    }
}

struct Case_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
            .environmentObject(TodayViewModel())
    }
}
