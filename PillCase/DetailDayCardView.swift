//
//  DetailDayCardView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 21.01.2023.
//

import SwiftUI

struct DetailDayCardView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 140, height: 120)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 4, y: 4)
                    .shadow(color: .white.opacity(0.99),  radius: 3, x: -4, y: -4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill (
                                .shadow(.inner(color: .white.opacity(0.10), radius: 20, x: 18, y: 8))
                            )
                            .foregroundColor(CustomColor.backGroundColor)
                        
                        Rectangle()
                            .frame(width: 140, height: 30)
                            .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
                            .foregroundColor(.pink)
                            .position(x: 70, y: 107)
                            
                    }
                VStack{
                    
                    HStack{
                        VStack {
                            Spacer()
                            Spacer()
                            Text("Декабрь")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.gray)
                            Text("01")
                                .font(.system(size: 56, weight: .medium, design: .default))
                                
                            
                            
                        }
                        HStack{
                            
                            VStack{
                                Spacer()
                                CourseDayView()
                                Spacer()
                            }
                            .padding(5)
                        }
                    }
                    Spacer()
                    
                    
                        Text("Воскресенье")
                            .font(.system(size: 14, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        Spacer()
                        Spacer()
                            
                    
                    
                }
                
                
            }
            Spacer()
        }
        .frame(width: 140, height: 140)
    }
}

struct DetailDayCardView_Previews: PreviewProvider {
    static var previews: some View {
        DetailDayCardView()
    }
}
