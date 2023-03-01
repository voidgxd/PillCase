//
//  CourseModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 28.02.2023.
//

import Foundation

struct Course: Identifiable {
    let courseColor: Int
    let courseName: String
    let startDate: Date
    let endDate: Date
    let dose: String
    let morning: Bool
    let day: Bool
    let evening: Bool
    let night: Bool
    let type: String
    let unit: String
    let id = UUID()
    let remainingDays: Int
    let regimen: String
    let numberOfPills: Int
    let douration: Int
}

