//
//  Extensions.swift
//  PillCase
//
//  Created by Максим Мосалёв on 22.02.2023.
//

import SwiftUI
import CoreData

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

//for notifications
extension Date {
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

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
}
#endif


extension PillCaseApp {
//
    func deleteExpiredPills(context: NSManagedObjectContext) {
        
        print("deleteExpiredPills called")
        
        let fetchRequest: NSFetchRequest<Pill> = Pill.fetchRequest()
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
        let predicate = NSPredicate(format: "date < %@", yesterday as NSDate)
        fetchRequest.predicate = predicate
        
        let expiredPills = try? context.fetch(fetchRequest)
        
        for pill in expiredPills ?? [] {
            context.delete(pill)
        }
        
        try? context.save()

    }

}

extension UIScreen {
    static var isZoomed: Bool {
        UIScreen.main.scale < UIScreen.main.nativeScale
    }
    
    static func calculateZoomScale() -> CGFloat {
        let scale = UIScreen.main.scale
        let nativeScale = UIScreen.main.nativeScale
        return scale / nativeScale
    }

}
// For zoomed mode
//extension CGFloat {
//    func zoomed() {
//        func scaled() -> CGFloat {
//            if UIScreen.isZoomed {
//                let scale = UIScreen.calculateZoomScale()
//                return self * scale
//            } else {
//                return self
//            }
//        }
//    }
//}

extension Int {
    func scaled() -> Int {
        if UIScreen.isZoomed {
            let scale = UIScreen.calculateZoomScale()
            return Int(Double(self) * scale)
        } else {
            return self
        }
    }
}

extension Double {
    func scaled() -> Double {
        if UIScreen.isZoomed {
            let scale = UIScreen.calculateZoomScale()
            return Double(Double(self) * scale)
        } else {
            return self
        }
    }
}
