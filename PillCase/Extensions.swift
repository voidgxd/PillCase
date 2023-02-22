//
//  Extensions.swift
//  PillCase
//
//  Created by Максим Мосалёв on 22.02.2023.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
