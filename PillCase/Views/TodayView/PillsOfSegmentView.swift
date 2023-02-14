//
//  PillsOfSegmentView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 14.02.2023.
//

import SwiftUI

struct PillsOfSegmentView: View {
    
    
    
//    var pillsTimeOfDay: [Pill] = []
    var pillsTimeOfDay = testArrayOfPills
    
    @State private var animationAmount: CGFloat = 0.95
    
    var body: some View {
        ZStack {
            SegmentView(color: CustomColor.morning, secondColor: CustomColor.morningSecond, shadowColor: CustomColor.morningShadow, degrees: 0, letter: "M", isEmpty: false)
            ZStack {
//                RoundedRectangle(cornerRadius: 35)
                if pillsTimeOfDay.isEmpty {
                    
                } else if pillsTimeOfDay.count == 1 {
                    Image(pillsTimeOfDay[2].type)
                        .resizable()
                        .frame(width: 80, height: 80)
                } else if pillsTimeOfDay.count == 2 {
                    
                            Image(pillsTimeOfDay[0].type)
                                .resizable()
                                .frame(width: 70, height: 70)
                                .position(x: 45, y: 45)
                            Image(pillsTimeOfDay[2].type)
                                .resizable()
                                .frame(width: 70, height: 70)
                                .position(x:95, y: 90)

                } else if pillsTimeOfDay.count == 3 {
                    
                    Image(pillsTimeOfDay[0].type)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .position(x: 62, y: 33)
                    Image(pillsTimeOfDay[1].type)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .position(x:35, y: 104)
                    Image(pillsTimeOfDay[2].type)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .position(x:105, y: 83)
                    
                } else if pillsTimeOfDay.count == 4 {
                    
                    SinglePillView(pillsTimeOfDay: testArrayOfPills, i: 0, frameWidth: 50, frameHeight: 50, positionX: 32, positionY: 38)
                    SinglePillView(pillsTimeOfDay: testArrayOfPills, i: 1, frameWidth: 50, frameHeight: 50, positionX: 40, positionY: 108)
                    
                    Image(pillsTimeOfDay[2].type)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .position(x:98, y: 43)
                    Image(pillsTimeOfDay[3].type)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .position(x:108, y: 106)
                }
                    
                
                
                
            }
            
            .clipShape(RoundedRectangle(cornerRadius: 35))
            .frame(width: 139, height: 139)
        }
    }
    
}

struct PillsOfSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        PillsOfSegmentView()
    }
}

struct SinglePillView: View {
    
    @State private var animationAmount: CGFloat = 0.97
    
    var pillsTimeOfDay: [TestPill]
    var i: Int
    var frameWidth: CGFloat
    var frameHeight: CGFloat
    var positionX: CGFloat
    var positionY: CGFloat
    
#warning("зарефакторить анимацию")
    var body: some View {
        Image(pillsTimeOfDay[i].type)
            .resizable()
            .frame(width: frameWidth, height: frameHeight)
            .position(x: positionX, y: positionY)
            .scaleEffect(CGFloat(animationAmount))

            .animation(
                Animation.easeInOut(duration: Double.random(in: 0.4...0.8))
                    .repeatForever(autoreverses: true)
                    .delay(Double.random(in: 0.01...0.3))
            )
            
            .onAppear {
                withAnimation {
                                self.animationAmount = 1
                            }
            }
    }
}
