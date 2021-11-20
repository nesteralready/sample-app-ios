//
//  TranslaterInteractor.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 19.11.2021.
//

import Foundation

protocol TranslaterInteractorProtocol {
    init(presenter: TranslaterPresenterProtocol)
    func getTranslateRequest(with text: String)
}

final class TranslaterInteractor: TranslaterInteractorProtocol {
    
    // MARK: - Private Methods
    
    private weak var presenter: TranslaterPresenterProtocol?
    
    private lazy var networkManager = NetworkManager()
    
    private lazy var coreDataManager = CoreDataManager.shared
    
    // MARK: - Init
    
    init(presenter: TranslaterPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getTranslateRequest(with text: String) {
        
        networkManager.getAuthentificationToken { result in
            switch result {
            case .failure(let error):
                switch error{
                case .noAuth:
                    self.presenter?.errNoAuth()
                case .internalError:
                    self.presenter?.errInternal()
                default:
                    self.presenter?.errInternal()
                }
            case .success(let token):
                
                self.networkManager.token = token
                self.networkManager.requestTranslate(with: text) { result in
                    switch result {
                    case .failure(let error):
                        switch error {
                        case .internalError:
                            self.presenter?.errInternal()
                        case .noAuth:
                            self.presenter?.errNoAuth()
                        case .noTranslateOrDictionary:
                            self.presenter?.errNoTranslation()
                        }
                    case .success(let translation):
                        self.presenter?.translationCompletlyFetched(translation: translation)
                        self.saveTranslationInCoreData(translation: translation)
                    }
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func saveTranslationInCoreData(translation: TranslaterModel) {
        let dbTranslate = DBTranslate(context: coreDataManager.container.viewContext)
        dbTranslate.original = translation.heading
        dbTranslate.dictionaryName = translation.translation.dictionaryName
        dbTranslate.translated =  translation.translation.translation  // lul )))0))
        
        coreDataManager.saveTranslation(translation: dbTranslate)
    }
}
