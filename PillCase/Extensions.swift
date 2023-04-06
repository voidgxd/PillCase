//
//  Extensions.swift
//  PillCase
//
//  Created by Максим Мосалёв on 22.02.2023.
//

import SwiftUI

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension Date {
    //for notifications
    func string() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}

extension DateComponents: Comparable {
    
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        let calendar = Calendar.current
        guard let lhsDate = calendar.date(from: lhs),
              let rhsDate = calendar.date(from: rhs) else {
            fatalError("Invalid date components")
        }
        return lhsDate < rhsDate
    }
}

//extension UISegmentedControl {
//    override open func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        self.setContentHuggingPriority(.defaultLow, for: .vertical)  // << here !!
//    }
//}
