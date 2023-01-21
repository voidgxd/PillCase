//
//  ScrollCurseView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 16.01.2023.
//

import SwiftUI

struct ScrollCurseView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20){
                Spacer()
                CurseCardView()
                CurseCardView()
                CurseCardView()
                CurseCardView()
                CurseCardView()
                CurseCardView()
                Spacer()
        
            }
        }
        .frame(height: 160)
        .background(CustomColor.backGroundColor)
        }

        
    
}

struct ScrollCurseView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollCurseView()
    }
}

struct CurseCardView: View {
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            ZStack {
                
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 120, height: 140)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 4, y: 4)
                    .shadow(color: .white.opacity(0.99),  radius: 3, x: -4, y: -4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill (
                                .shadow(.inner(color: .white.opacity(0.10), radius: 20, x: 18, y: 8))
                            )
                            .foregroundColor(CustomColor.backGroundColor)
                            
                    }
                VStack{
                    HStack{
                        VStack {
                            Text("Декабрь")
                                .font(.system(size: 12, weight: .semibold, design: .default))
                                .foregroundColor(.gray)
                            Text("01")
                                .font(.system(size: 48, weight: .medium, design: .default))
                            Spacer()
                            
                        }
                        VStack{
                            CourseDayView()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            
                        }
                        
                    }
                    Divider()
                    ScrollView {
                        Text("Витамин Д 150мг - 3 р.")
                            .font(.system(size: 8, weight: .light, design: .default))
                        Text("Пенталгин 1шт - 2 р.")
                            .font(.system(size: 8, weight: .light, design: .default))
                        Text("Витамин Д 150мг - 3 р.")
                            .font(.system(size: 8, weight: .light, design: .default))
                        Text("Витамин Д 150мг - 3 р.")
                            .font(.system(size: 8, weight: .light, design: .default))
                    }
                    
                }
                .padding(5)
                
            }
            Spacer()
        }
    }
}
