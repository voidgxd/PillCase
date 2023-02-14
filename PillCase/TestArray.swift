//
//  TestArray.swift
//  PillCase
//
//  Created by Максим Мосалёв on 14.02.2023.
//

import Foundation

var testArrayOfPills: [TestPill] = [TestPill(courseName: "Витамин", date: .now, timeOfDay: "morning", dose: 1, id: UUID(), type: "Pill3", unit: "мг"), TestPill(courseName: "Анальгин", date: .now, timeOfDay: "morning", dose: 2, id: UUID(), type: "RoundPill3", unit: "мг"), TestPill(courseName: "Омега 3", date: .now, timeOfDay: "morning", dose: 3, id: UUID(), type: "Syringe", unit: "мг"), TestPill(courseName: "Колдрекс", date: .now, timeOfDay: "morning", dose: 4, id: UUID(), type: "Powder", unit: "мг") ]

struct TestPill {
    var courseName:String
    var date: Date
    var timeOfDay: String
    var dose: Int
    var id: UUID
    var type: String
    var unit: String
    
    
    
}
//func createPills() {
//    
//  let a = TestPill(courseName: "Витамин", date: .now, timeOfDay: "morning", dose: 1, id: UUID(), type: "Pill3", unit: "мг")
//    testArrayOfPills.append(a)
//let b = TestPill(courseName: "Анальгин", date: .now, timeOfDay: "morning", dose: 2, id: UUID(), type: "RoundPill3", unit: "мг")
//    testArrayOfPills.append(b)
//    let c = TestPill(courseName: "Омега 3", date: .now, timeOfDay: "morning", dose: 3, id: UUID(), type: "Syringe", unit: "мг")
//    testArrayOfPills.append(c)
//    let d = TestPill(courseName: "Колдрекс", date: .now, timeOfDay: "morning", dose: 4, id: UUID(), type: "Powder", unit: "мг")
//    testArrayOfPills.append(d)
//}



