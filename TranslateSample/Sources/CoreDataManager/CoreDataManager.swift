//
//  CoreDataManager.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 20.11.2021.
//
import CoreData

final class CoreDataManager {
    
    static var shared = CoreDataManager()
    
    // MARK: - Public Properties
    
    public var container = NSPersistentContainer(name: "TranslatesHistory")
    
    // MARK: - Init
    
    private init () {
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("store is ready")
            }
        }
    }
    
    // MARK: - Public Methods
    
    func saveTranslation(translation: DBTranslate) {
        container.performBackgroundTask { context in
            context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            
            let dbTranslation = DBTranslate(context: context)
            dbTranslation.original = translation.original
            dbTranslation.dictionaryName = translation.dictionaryName
            dbTranslation.translated = translation.translated
            
            do {
                try context.save()
            } catch {
                print("unrec error", error.localizedDescription)
            }
        }
    }
}
