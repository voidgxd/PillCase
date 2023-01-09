//
//  TimeOfDay.swift
//  PillCase
//
//  Created by Максим Мосалёв on 10.01.2023.
//

import Foundation

public struct TimeOfDay {
    
    struct Morning {
        static let mainColor = CustomColor.morning
        static let secondColor = CustomColor.morningSecond
        static let shadowColor = CustomColor.morningShadow
        
        static let letter = "M"
        
        struct Coordinates {
            static let emptyMorningShadowX: CGFloat = 6
            static let emptyMorningShadowY: CGFloat = 6
            static let emptyMorningLightX: CGFloat = -8
            static let emptyMorningLightY: CGFloat = -8
            
            static let filledMorningShadowX: CGFloat = 4
            static let filledMrningShadowY: CGFloat = 4
            static let filledMorningLightX: CGFloat = -16
            static let filledMorningLightY: CGFloat = -16
        }
    }
}
