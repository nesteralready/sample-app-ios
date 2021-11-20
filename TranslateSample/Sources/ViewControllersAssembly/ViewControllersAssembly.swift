//
//  ViewControllersAssembly.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 19.11.2021.
//

import UIKit

final class ViewControllerAssembly: ViewControllerAssemblyProtocol {
    
    func makeRootViewController(router: TranslaterRouterProtocol) -> UIViewController {
        let viewController = TranslaterViewController()
        let presenter = TranslaterPresenter(view: viewController)
        let interactor = TranslaterInteractor(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
        return viewController
    }
    
    func makeHistoryViewController() -> UIViewController {
        let viewController = HistoryViewController()
        return viewController
    }
}
