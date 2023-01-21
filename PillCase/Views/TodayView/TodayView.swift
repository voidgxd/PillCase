//
//  Case.swift
//  PillCase
//
//  Created by Максим Мосалёв on 07.01.2023.
//

import SwiftUI

struct TodayView: View {
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Divider()
                ScrollTodayView(dateDay: 21, dateMonth: "Ноябрь", morningNumberOfPills: 2, dayNumberOfPills: 4, eveningNumberOfPills: 1, nightNumberOfPills: 3)
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
                                
                                SegmentView(color: CustomColor.morning, secondColor: CustomColor.morningSecond, shadowColor: CustomColor.morningShadow, degrees: 0, letter: "M", isEmpty: false)
                                    .overlay {
                                        LetterView(color: CustomColor.morning, shadowColor: CustomColor.morningShadow, letter: "M", degrees: 0, positionX: 142.5, positionY: 142)
                                    }
                                
                                
                                SegmentView(color: CustomColor.day, secondColor: CustomColor.daySecond, shadowColor: CustomColor.dayShadow, degrees: 90, letter: "D", isEmpty: true)
                                    .overlay {
                                        LetterView(color: CustomColor.day, shadowColor: CustomColor.dayShadow, letter: "D", degrees: 0, positionX: 7.5, positionY: 142)
                                    }
                                
                                
                            }
                            HStack (spacing: 0) {
                                SegmentView(color: CustomColor.night, secondColor: CustomColor.nightSecond, shadowColor: CustomColor.nightShadow, degrees: -90, letter: "N", isEmpty: true)
                                    .overlay {
                                        LetterView(color: CustomColor.night, shadowColor: CustomColor.nightShadow, letter: "N", degrees: 0, positionX: 142.5, positionY: 8)
                                    }
                                SegmentView(color: CustomColor.evening, secondColor: CustomColor.eveningSecond, shadowColor: CustomColor.eveningShadow, degrees: 180, letter: "E", isEmpty: false)
                                    .overlay {
                                        LetterView(color: CustomColor.evening, shadowColor: CustomColor.eveningShadow, letter: "E", degrees: 0, positionX: 7.5, positionY: 8)
                                    }
                            }
                        }
                    }
                }
                .padding()
                .fixedSize(horizontal: false, vertical: false)
              
                Spacer()
                Spacer()
                Divider()
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(CustomColor.morning, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "list.bullet").foregroundColor(.white
                        )
                        .font(.system(size: 22, weight: .bold))
                    }
                }
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("PillCase")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "pills.circle").foregroundColor(.white
                        )
                        .font(.system(size: 22, weight: .bold))
                    }
                }
                
            }
            .background(CustomColor.backGroundColor)
        }
        
    }
}

struct Case_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
//            .previewDevice("iPhone SE (3nd generation)")
    }
}
