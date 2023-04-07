//
//  CourseDayView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 30.01.2023.
//

import SwiftUI

struct CourseDayView: View {
    var morning: Bool = false
    var day: Bool = false
    var evening: Bool = false
    var night: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 46, height: 46)
                .foregroundColor(CustomColor.backGroundColor)
                .shadow(color: .black.opacity(0.2), radius: 2, x:3, y: 3)
                .shadow(color: .white.opacity(0.8),  radius: 2, x: -3, y: -3)
            
            VStack {
                VStack (spacing: 2){
                    HStack (spacing: 2) {
                        HStack{
                            // morning
                            Rectangle().cornerRadius(10, corners: .topLeft)
                                .frame(width: 20, height: 20)
                                .foregroundColor(CustomColor.morning)
                                .opacity(morning ? 1.0 : 0)
                        }
                        HStack{
                            // day
                            Rectangle().cornerRadius(10, corners: .topRight)
                                .frame(width: 20, height: 20)
                                .foregroundColor(CustomColor.day)
                                .opacity(day ? 1.0 : 0)
                        }
                    }
                    HStack(spacing: 2) {
                        HStack{
                            // night
                            Rectangle().cornerRadius(10, corners: .bottomLeft)
                                .frame(width: 20, height: 20)
                                .foregroundColor(CustomColor.night)
                                .opacity(night ? 1.0 : 0)
                        }
                        HStack{
                            // evening
                            Rectangle().cornerRadius(10, corners: .bottomRight)
                                .frame(width: 20, height: 20)
                                .foregroundColor(CustomColor.evening)
                                .opacity(evening ? 1.0 : 0)
                        }
                    }
                }
            }
        }
    }
}

struct CourseDayView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDayView(morning: true, day: true, evening: true, night: true)
    }
}
