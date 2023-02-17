//
//  PillsOfSegmentView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 14.02.2023.
//

import SwiftUI

struct PillsOfSegmentView: View {

    var pillsTimeOfDay: [Pill] = []
        
    var body: some View {
        
        ZStack {
            
            
            if pillsTimeOfDay.isEmpty {
                
            } else if pillsTimeOfDay.count == 1 {
                SinglePillView(pillsTimeOfDay: pillsTimeOfDay, i: 0, frameWidth: 80, frameHeight: 80, positionX: 69.5, positionY: 69.5)
                
            } else if pillsTimeOfDay.count == 2 {
                SinglePillView(pillsTimeOfDay: pillsTimeOfDay, i: 0, frameWidth: 70, frameHeight: 70, positionX: 45, positionY: 45)
                SinglePillView(pillsTimeOfDay: pillsTimeOfDay, i: 1, frameWidth: 70, frameHeight: 70, positionX: 95, positionY: 95)
                
                
            } else if pillsTimeOfDay.count == 3 {
                SinglePillView(pillsTimeOfDay: pillsTimeOfDay, i: 0, frameWidth: 60, frameHeight: 60, positionX: 62, positionY: 33)
                SinglePillView(pillsTimeOfDay: pillsTimeOfDay, i: 1, frameWidth: 60, frameHeight: 60, positionX: 35, positionY: 104)
                SinglePillView(pillsTimeOfDay: pillsTimeOfDay, i: 2, frameWidth: 60, frameHeight: 60, positionX: 105, positionY: 83)
            } else if pillsTimeOfDay.count == 4 {
                
                SinglePillView(pillsTimeOfDay: pillsTimeOfDay, i: 0, frameWidth: 50, frameHeight: 50, positionX: 32, positionY: 38)
                SinglePillView(pillsTimeOfDay: pillsTimeOfDay, i: 1, frameWidth: 50, frameHeight: 50, positionX: 40, positionY: 108)
                SinglePillView(pillsTimeOfDay: pillsTimeOfDay, i: 2, frameWidth: 50, frameHeight: 50, positionX: 98, positionY: 43)
                SinglePillView(pillsTimeOfDay: pillsTimeOfDay, i: 3, frameWidth: 50, frameHeight: 50, positionX: 108, positionY: 106)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 35))
        .frame(width: 139, height: 139)
    }
}

struct PillsOfSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        PillsOfSegmentView()
    }
}

struct SinglePillView: View {
    
    @State private var isAnimating = false
    
    var pillsTimeOfDay: [Pill]
    var i: Int
    var frameWidth: CGFloat
    var frameHeight: CGFloat
    var positionX: CGFloat
    var positionY: CGFloat

    var body: some View {
            VStack {
                Image(pillsTimeOfDay[i].type!)
                    .resizable()
                    .frame(width: frameWidth, height: frameHeight)
                    .position(x: positionX, y: positionY)
                    .scaleEffect(isAnimating ? 1.0 : 0.97)
                    .shadow(radius: 12)
                    .animation(Animation.easeInOut(duration: Double.random(in: 0.5...0.8))
                                .repeatForever(autoreverses: true)
                                .delay(Double.random(in: 0.01...0.1)), value: isAnimating)
                    .onAppear {
                        self.isAnimating = true
                    }
            }
        }
    }


