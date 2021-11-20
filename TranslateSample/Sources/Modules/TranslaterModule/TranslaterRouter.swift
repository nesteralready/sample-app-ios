//
//  TranslaterRouter.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 19.11.2021.
//

import UIKit

protocol TranslaterRouterProtocol: Routable {
    func initialViewController()
    func openHistoryViewController()
}

final class TranslaterRouter: TranslaterRouterProtocol {
    // MARK: - Properties
    
    var navigationController: UINavigationController?
    
    var viewControllerAssembly: ViewControllerAssemblyProtocol?
    
    // MARK: - Init
    
    init(navigationController: UINavigationController, viewControllerAssembly: ViewControllerAssemblyProtocol) {
        self.navigationController = navigationController
        self.viewControllerAssembly = viewControllerAssembly
    }
    
    // MARK: - Methods
    
    func initialViewController() {
        if let initialViewController = viewControllerAssembly?.makeRootViewController(router: self) {
            navigationController?.viewControllers = [initialViewController]
        }
    }
    
    func openHistoryViewController() {
        if let historyVC = viewControllerAssembly?.makeHistoryViewController() {
            navigationController?.pushViewController(historyVC, animated: true)
        }
    }
}
