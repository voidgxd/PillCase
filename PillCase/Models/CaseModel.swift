//
//  CaseModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 07.01.2023.
//

import Foundation

struct Case {
    let morningSection: [Pill] = []
    let daySection: [Pill] = []
    let eveningSection: [Pill] = []
    let nightSection: [Pill] = []
  
    enum timeOfDay {
        case morning
        case day
        case evening
        case night
    }
    
 
}
