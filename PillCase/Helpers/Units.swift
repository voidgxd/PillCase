//
//  Units.swift
//  PillCase
//
//  Created by Максим Мосалёв on 07.04.2023.
//

import Foundation
import SwiftUI

enum DoseUnits: String {

    case g = "g"
    case mg = "mg"
    case mcg = "mcg"
    case L = "L"
    case ml = "ml"
    case oz = "oz"
    case IU = "IU"
    case tbsp = "tbsp"
    case tsp = "tsp"
    case drops = "drp"
    case sprays = "spra"
    case pcs = "pcs"

}


enum RegimenOption: String {
    case everyDay = "every day"
    case everyOtherDay = "every other day"
    case everyThreeDays = "every 3 days"
    case onceAWeek = "once a week"
}
