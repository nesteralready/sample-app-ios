//
//  Routable.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 19.11.2021.
//

import UIKit

protocol Routable {
    var navigationController: UINavigationController? { get set }
    var viewControllerAssembly: ViewControllerAssemblyProtocol? { get set }
}
