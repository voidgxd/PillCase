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
        
        debugPrint("deleteExpiredPills called")
        
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

// MARK: Extension для внутренних теней текста
extension Text {
    func innerShadow<V: View>(_ background: V, radius: CGFloat = 5, offsetX: CGFloat = 5, offsetY: CGFloat = 5, opacity: Double = 0.7) -> some View {
        self
            .foregroundColor(.clear)
            .overlay (background.mask(self))
            .overlay(
                ZStack {
                    self.foregroundColor(Color (white: 1 - opacity))
                    self.foregroundColor(.white).blur(radius: radius).offset(x: offsetX, y: offsetY)
                }
                    .mask(self)
                    .blendMode (.multiply)
            )
    }
}

// MARK: For zoomed mode

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

// MARK: Extension для закругленния отдельных углов

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
