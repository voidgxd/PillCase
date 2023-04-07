//
//  CoreDataManager.swift
//  PillCase
//
//  Created by Максим Мосалёв on 09.02.2023.
//

import Foundation
import CoreData

class CoreDataManager {

  static let shared = CoreDataManager()

  private init() {}

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "PillModel")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
      print("its ok")
    return container
  }()

  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
}
