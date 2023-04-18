//
//  MonthStruct.swift
//  PillCase
//
//  Created by Максим Мосалёв on 06.03.2023.
//

import Foundation
import SwiftUI


struct MonthStruct
{
    var monthType: MonthType
    var dayInt : Int
    func day() -> String
    {
        return String(dayInt)
    }
}

enum MonthType
{
    case Previous
    case Current
    case Next
}
