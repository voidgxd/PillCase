//
//  LetterView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 17.01.2023.
//

import SwiftUI

struct LetterView: View {
    let color: Color
    let shadowColor: Color
    let letter: String
    let degrees: CGFloat
    let positionX: CGFloat
    let positionY: CGFloat
    
    var body: some View {
        
        HStack{
            Text(letter)
                .font(.system(size: 12, weight: .medium, design: .monospaced))
            
                .innerShadow(LinearGradient(gradient: Gradient(colors: [shadowColor, color]), startPoint: .bottomLeading, endPoint: .topTrailing), radius: 0.9, offsetX: 0.1, offsetY: 0.5, opacity: 0.1)
                .position(x:positionX, y: positionY)
                .rotationEffect(.degrees(-degrees), anchor: .center)
        }
    }
}


