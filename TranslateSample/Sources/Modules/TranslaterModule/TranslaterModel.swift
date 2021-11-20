//
//  TranslaterModel.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 19.11.2021.
//

import Foundation

import Foundation

// MARK: - TranslaterModel

struct TranslaterModel: Codable {
    let sourceLanguage, targetLanguage: Int
    let translation: Translation
    let heading: String
    
    enum CodingKeys: String, CodingKey {
           case sourceLanguage = "SourceLanguage"
           case targetLanguage = "TargetLanguage"
           case translation = "Translation"
           case heading = "Heading"
    }
}

// MARK: - Translation
struct Translation: Codable {
    let translation, dictionaryName: String
    
    enum CodingKeys: String, CodingKey {
         case translation = "Translation"
         case dictionaryName = "DictionaryName"
     }
}
