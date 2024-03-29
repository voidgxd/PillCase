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

public func getColor(colorInt :Int) -> Color {
    switch colorInt {
    case 0: return CustomColor.firstCourse
    case 1: return CustomColor.secondCourse
    case 2: return CustomColor.thirdCourse
    case 3: return CustomColor.fourthCourse
    default: return CustomColor.firstCourse
    }
}

public func stringToInt(_ string: String) -> Int? {
    return Int(string)
}

public func daysFromNow(to date: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: Date(), to: date)
        return components.day ?? 0
}

public func daysBetweenDates(_ startDate: Date, _ endDate: Date) -> Int {
    let calendar = Calendar.current
    let startOfStartDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: startDate)!
    let startOfEndDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: endDate)!
    let components = calendar.dateComponents([.day], from: startOfStartDate, to: startOfEndDate)
    if let days = components.day {
        return days + 1
    } else {
        return 0
    }
    
    
   func calculateZoomScale() -> CGFloat{
        print(UIScreen.main.scale)
        print(UIScreen.main.nativeScale)
        var result = UIScreen.main.nativeScale/UIScreen.main.scale
        print(result)
        return result
    }
    
}
