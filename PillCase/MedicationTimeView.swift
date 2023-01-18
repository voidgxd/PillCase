//
//  MedicationTimeView.swift
//  PillCase
//
//  Created by Максим Мосалёв on 18.01.2023.
//

import SwiftUI

struct MedicationTimeView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                
                .frame(width: 296, height: 100)
                .foregroundColor(CustomColor.backGroundColor)
//                .shadow(color: .black.opacity(0.30), radius: 5, x: 9, y: 9)
//                .shadow(color: .white.opacity(1),  radius: 4, x: -9, y: -9)
                .overlay {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill (
                            .shadow(.inner(color:.black.opacity(0.25),radius: 4, x: 6, y: 6))
                                                    .shadow(.inner(color: .white.opacity(0.55), radius: 4, x: -8, y: -8))
                        )
                        .foregroundColor(CustomColor.backGroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
        }
    }
}

struct MedicationTimeView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationTimeView()
    }
}
