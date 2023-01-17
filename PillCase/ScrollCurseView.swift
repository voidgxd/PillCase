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
            HStack{
                Spacer()
                ExtractedView()
                ExtractedView()
                ExtractedView()
                ExtractedView()
                ExtractedView()
                ExtractedView()
                Spacer()
        
            }
        }
        .frame(height: 120)
        }

        
    
}

struct ScrollCurseView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollCurseView()
    }
}

struct ExtractedView: View {
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            ZStack {
                
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 120, height: 140)
                    .foregroundColor(.gray)
                    .shadow(color: .black.opacity(0.3), radius: 4, x:4, y: 4)
                    .shadow(color: .white.opacity(0.2),  radius: 8, x: -16, y: -16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill (
                                .shadow(.inner(color: .white.opacity(0.15), radius: 20, x: 18, y: 8))
                            )
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
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
