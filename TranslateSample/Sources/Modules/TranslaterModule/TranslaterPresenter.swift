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
}

protocol OutputTranslatorInteractorProtocol: AnyObject {
    func translationCompletlyFetched(translation: TranslaterModel)
    func errTranslationFetched(with error: FetchError)
}

final class TranslaterPresenter: TranslaterPresenterProtocol {
 
    // MARK: - Public Properties
    
    public weak var view: TranslaterViewProtocol?
    public var interactor: TranslaterInteractorProtocol?
    public var router: TranslaterRouterProtocol?
    
    // MARK: - Init
    
    required init(view: TranslaterViewProtocol) {
        self.view = view
    }
    
    // MARK: - Public Methods
    
    func historyButtonDidTapped() {
        router?.openHistoryViewController()
    }
    
    func sendRequest(with text: String){
        interactor?.getTranslateRequest(with: text)
    }
}

// MARK: - OutputInteractor

extension TranslaterPresenter: OutputTranslatorInteractorProtocol {
    func errTranslationFetched(with error: FetchError) {
        self.view?.errDataFetch(with: error.localizedDescription)
    }
    
    func translationCompletlyFetched(translation: TranslaterModel) {
        DispatchQueue.main.async {
            let translated = "\(translation.heading) \n\(translation.translation.translation) \n\(translation.translation.dictionaryName)"
            self.view?.onTranslateCompletlyFetched(translation: translated)
        }
    }
    
}
