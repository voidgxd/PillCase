//
//  MedicationTimeView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 18.01.2023.
//

import SwiftUI

struct MedicationTimeView: View {
    var headerColor: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 360 ,height: 120)
                .foregroundColor(CustomColor.backGroundColor)
                .overlay {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill (
                            .shadow(.inner(color:.black.opacity(0.45),radius: 3, x: 4, y: 4))
                            .shadow(.inner(color: .white.opacity(0.60), radius: 2, x: -6, y: -6))
                        )
                        .foregroundColor(CustomColor.backGroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    VStack{
                        Rectangle()
                            .frame(height:28)
                            .cornerRadius(16, corners: [.topLeft, .topRight])
                            .foregroundColor(headerColor)
                        Spacer()
                    }
                }
        }
    }
}

struct MedicationTimeView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationTimeView(headerColor: .blue)
    }
}
