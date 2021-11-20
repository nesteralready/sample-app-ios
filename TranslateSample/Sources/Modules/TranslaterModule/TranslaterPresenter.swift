//
//  TranslaterPresenter.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 19.11.2021.
//

import Foundation

protocol TranslaterPresenterProtocol: AnyObject {
    init(view: TranslaterViewProtocol)
    func historyButtonDidTapped()
    func sendRequest(with text: String)
    func translationCompletlyFetched(translation: TranslaterModel)
    
    func errNoAuth()
    func errNoTranslation()
    func errInternal()
}

final class TranslaterPresenter: TranslaterPresenterProtocol {
 
    // MARK: Public Properties
    
    public weak var view: TranslaterViewProtocol?
    public var interactor: TranslaterInteractorProtocol?
    public var router: TranslaterRouterProtocol?
    
    // MARK: Init
    
    required init(view: TranslaterViewProtocol) {
        self.view = view
    }
    
    func historyButtonDidTapped() {
        router?.openHistoryViewController()
    }
    
    func sendRequest(with text: String){
        interactor?.getTranslateRequest(with: text)
    }
    
    func translationCompletlyFetched(translation: TranslaterModel) {
        DispatchQueue.main.async {
            let translated = "\(translation.heading) \n\(translation.translation.translation) \n\(translation.translation.dictionaryName)"
            self.view?.onTranslateCompletlyFetched(translation: translated)
        }
    }
 
    func errInternal() {
        DispatchQueue.main.async {
            self.view?.errTranslateDataFetched()
        }
    }
    
    func errNoAuth() {
        DispatchQueue.main.async {
            self.view?.errAuthorization()
        }
    }
    
    func errNoTranslation() {
        DispatchQueue.main.async {
            self.view?.errNoTranslation()
        }
    }
}
