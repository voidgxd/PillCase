//
//  PillModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 08.01.2023.
//

import Foundation

struct Pill {
    enum type {
        case round
        case halfRound
        case capsule
        case rectangle // Возможно разделить на половину, четверти, 3/4, 1/4
        case pentalgin
        case halfPentalgin
        // Нужно подумать над возможными формами
    }
    
    let isFilled: Bool // Заполняем краской внутренность таблетки или внутренняя часть прозрачная
    
    let name: String
    let abbreviation: String // Подумать над кол-вом символов
    let dose: String // Подумать над форматом дозировки
    let beforeEateing: Bool
    
}


