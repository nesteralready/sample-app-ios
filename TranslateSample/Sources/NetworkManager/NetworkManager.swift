//
//  NetworkManager.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 20.11.2021.
//

import Foundation

public enum FetchError: Error {
    case noAuth
    case noTranslateOrDictionary
    case internalError
}

final class NetworkManager {
    
    // MARK: - Public properties
    
    public var token: String?
    
    // MARK: - Private properties
    
    private let apiKey = "MThiNzA1NzQtOGU0NS00MzRjLTg1Y2ItMTc4ZDA1Y2Q3M2YwOjQyOTk4NTQ0MDc0MjQ2ZmY5MDU2ODQwOWRiZjVmNTM1"
    
    private let url_auth = "https://developers.lingvolive.com/api/v1.1/authenticate"
    
    private let url_translate = "https://developers.lingvolive.com/api/v1/Minicard"
    
    private let srcLang = Languages.en.rawValue
    
    private let distLang = Languages.ru.rawValue
    
    private let parser = Parser()
    
    // MARK: - Public Methods
    
    public func requestTranslate(with word: String, completion: ( (Result<TranslaterModel, FetchError>) -> Void)? = nil){
        guard let token = token else {
            completion?(.failure(.noAuth))
            return
        }
        
        guard var components = URLComponents(string: url_translate) else {
            completion?(.failure(.internalError))
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "text", value: word),
            URLQueryItem(name: "srcLang", value: "\(srcLang)"),
            URLQueryItem(name: "dstLang", value: "\(distLang)")]
        
        guard let url = components.url else {
            completion?(.failure(FetchError.internalError))
            return
        }
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, response, err in
            if err != nil {
                completion?(.failure(FetchError.internalError))
            }
            
            guard let data = data,
                  let translate: TranslaterModel = self.parser.parseJSON(with: data) else {
                completion?(.failure(FetchError.noTranslateOrDictionary))
                return
            }
            completion?(.success(translate))
        }
        task.resume()
    }
    
    public func getAuthentificationToken(completion: @escaping (Result<String, FetchError>) -> Void) {
        
        if let token = token {
            completion(.success(token))
            return
        }
        
        guard let url = URL(string: url_auth) else {
            return completion(.failure(.noAuth))
        }
        
        var request = URLRequest(url: url)
        request.setValue("Basic \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, err in
            if err != nil {
                return completion(.failure(.internalError))
            }
            
            guard let data = data,
                  let token = String(data: data, encoding: .utf8) else {
                return completion(.failure(.internalError))
            }
            
            completion(.success(token))
        }
        task.resume()
    }
    
}
