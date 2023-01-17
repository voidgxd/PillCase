//
//  CourseDayView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 16.01.2023.
//

import SwiftUI

struct CourseDayView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                
                .frame(width: 46, height: 46)
                .foregroundColor(CustomColor.backGroundColor)
                .shadow(color: .black.opacity(0.2), radius: 2, x:3, y: 3)
                .shadow(color: .white.opacity(0.8),  radius: 2, x: -6, y: -6)
            VStack {
                VStack (spacing: 2){
                    HStack (spacing: 2) {
                        HStack{
                            CourseDaySegmentView(numberOfPillsInSection: 1)
                                .foregroundColor(CustomColor.morning)
                            
                        }
                        HStack{
                            CourseDaySegmentView(numberOfPillsInSection: 2)
                                .foregroundColor(CustomColor.day)
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 360, z: 0))
                                
                                
                        }
                    }
                    HStack(spacing: 2) {
                        HStack{
                            CourseDaySegmentView(numberOfPillsInSection: 1)
                                .foregroundColor(CustomColor.night)
                                .rotation3DEffect(.degrees(180), axis: (x: 360, y:0 , z: 0))
                        }
                        HStack{
                            CourseDaySegmentView(numberOfPillsInSection: 3)
                                .foregroundColor(CustomColor.evening)
                                .rotationEffect(.degrees(180))
                        }
                    }
                }
            
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 50, height: 50)
            
            
        }
        
        
    }
}

struct CourseDaySegmentView: View {
    var numberOfPillsInSection: Int
    
    var body: some View {
        VStack(spacing: 1) {
        HStack(spacing: 1) {
            PillRectangle()
                .opacity(numberOfPillsInSection >= 4 ? 1.0 : 0.0)
            PillRectangle()
                .opacity(numberOfPillsInSection >= 3 ? 1.0 : 0.0)
            
        }
        
        HStack(spacing: 1) {
            PillRectangle()
                .opacity(numberOfPillsInSection >= 2 ? 1.0 : 0.0)
                
            PillRectangle()
                .opacity(numberOfPillsInSection >= 1 ? 1.0 : 0.0)
        }
    }
        
        .fixedSize(horizontal: false, vertical: false)
        
}
    
}


struct PillRectangle: View {
    var body: some View {
        VStack(spacing: 1){
            RoundedRectangle(cornerRadius: 1)
                .frame(width: 9, height: 9)
        }
    }
}

struct CourseDayView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDayView()
        
            
        
    }
    
}


