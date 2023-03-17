//
//  MainViewModel.swift
//  PillCase
//
//  Created by Максим Мосалёв on 17.03.2023.
//

import Foundation
import CoreData

class MainViewModel: ObservableObject {
    
    
    @Published var pills: [Pill] = []
    
}
