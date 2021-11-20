//
//  ViewControllerAssemblyProtocol.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 19.11.2021.
//

import UIKit

protocol ViewControllerAssemblyProtocol {
    func makeRootViewController(router: TranslaterRouterProtocol) -> UIViewController
    func makeHistoryViewController() -> UIViewController
}
