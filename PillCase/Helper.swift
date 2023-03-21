//
//  Helper.swift
//  PillCase
//
//  Created by Максим Мосалёв on 21.03.2023.
//


import SwiftUI

public func roundWhichCorner(position: Int) -> UIRectCorner {
    
    switch position {
    case 0: return .topLeft
    case 1: return .topRight
    case 2: return .bottomLeft
    case 3: return .bottomRight
    default: return .allCorners
    }
    
}
