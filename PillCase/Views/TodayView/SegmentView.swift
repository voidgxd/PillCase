//
//  SegmentView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 09.01.2023.
//

import SwiftUI



struct SegmentView: View {
    
    @State var color: Color
    @State var secondColor: Color
    @State var shadowColor: Color
    @State var degrees: Double

    let letter: String
    var isEmpty: Bool

    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 150, height: 150)
                .cornerRadius(40, corners: .topLeft)
                .foregroundColor(color)
                .overlay {
                }
                .rotationEffect(.degrees(degrees))
                if isEmpty {
                    EmptyContainerView(secondColor: secondColor, shadowColor: shadowColor)
                } else {
                    FilledContainerView(color: color,secondColor: secondColor, shadowColor: shadowColor)
                }
        }
    }
}

// MARK: Subview for not empty container
struct FilledContainerView: View {
    let color: Color
    let secondColor: Color
    let shadowColor: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 35)
            .frame(width: 139, height: 139)
            .foregroundColor(color)
            .overlay {
                RoundedRectangle(cornerRadius: 33, style: .continuous)
                    .fill (
                                                    .shadow(.inner(color:shadowColor.opacity(0.43),radius: 4, x: 6, y: 6))
                                                .shadow(.inner(color: .white.opacity(0.38), radius: 16, x: -8, y: -8))
                    )
                    .foregroundColor(color)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
            }
    }
}
// MARK: Subview for empty container
struct EmptyContainerView: View {
    let secondColor: Color
    let shadowColor: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 35)
            .frame(width: 139, height: 139)
            .foregroundColor(secondColor)
            .shadow(color: shadowColor.opacity(0.5), radius: 4, x:4, y: 4)
            .shadow(color: .white.opacity(0.2),  radius: 16, x: -16, y: -16)
            .overlay {
                RoundedRectangle(cornerRadius: 33, style: .continuous)
                    .fill (
                                                .shadow(.inner(color: .white.opacity(0.15), radius: 20, x: 18, y: 8))
                    )
                    .foregroundColor(secondColor)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
            }
    }
}

struct SegmentView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentView(color: CustomColor.night, secondColor: CustomColor.nightSecond, shadowColor: CustomColor.night, degrees: 0, letter: "M", isEmpty: false)
        
    }
}






