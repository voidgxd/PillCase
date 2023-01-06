//
//  ContentView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 06.01.2023.
//

import SwiftUI

struct RoundPill: View {
    var color: Color
    
    var body: some View {
        ZStack {
            Path { path in
                path.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
            }
            .stroke(color, lineWidth: 10)
            
            Path { path in
                // MARK: Отрисовка середины
                // Обратить внимание на координаты при ресайзиге, при нажатии пересечения становятся видны.
                path.move(to: CGPoint(x: 5, y: 50))
                path.addLine(to: CGPoint(x: 95, y: 50))
                path.move(to: CGPoint(x: 0, y: 0))
            }
            .stroke(color, lineWidth: 6)
           
            
        }
        .frame(width: 100, height: 100)
        .padding()
    }
        
      
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RoundPill(color: .blue)
    }
}
