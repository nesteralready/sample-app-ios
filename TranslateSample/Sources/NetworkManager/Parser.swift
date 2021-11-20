//
//  Parser.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 20.11.2021.
//

import Foundation

final class Parser {
    
    // MARK: - Public MMethods
    
    func parseJSON<T:Decodable>(with data: Data) -> T? {
        let decoder = newJSONDecoder()
        
        do {
            let obj = try decoder.decode(T.self, from: data)
            return obj
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    // MARK: - Private Methods
    
    private func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
