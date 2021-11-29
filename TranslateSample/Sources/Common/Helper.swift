//
//  Helper.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 20.11.2021.
//

import UIKit

// Всплывающий баннер снизу. Показывает ошибку с сервера. 

func showToast(message : String, duration: TimeInterval = 4.0, delay: TimeInterval = 2.5, vc: UIViewController) {

    let toast: UIButton = {
        let toastLabel = UIButton()
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.backgroundColor = .black
        toastLabel.setTitleColor(.white, for: .normal)
        toastLabel.titleLabel?.numberOfLines = 2
        toastLabel.titleLabel?.textAlignment = .center
        toastLabel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        toastLabel.setTitle(message, for: .normal)
        toastLabel.alpha = 0.95
        toastLabel.layer.cornerRadius = 11;
        toastLabel.clipsToBounds  =  true
        toastLabel.isUserInteractionEnabled = false
        toastLabel.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return toastLabel
    }()
    
    vc.view.addSubview(toast)
    
    let toastConstraints = [toast.topAnchor.constraint(equalTo: vc.view.bottomAnchor),
                            toast.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
                            toast.heightAnchor.constraint(equalToConstant: 65),
                            toast.widthAnchor.constraint(equalTo: vc.view.widthAnchor, multiplier: 0.9)
    ]
    
    let toastUpConstraints = [toast.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor,constant: -60),
                            toast.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
                            toast.heightAnchor.constraint(equalToConstant: 65),
                            toast.widthAnchor.constraint(equalTo: vc.view.widthAnchor, multiplier: 0.9)
    ]
    
    let toastDownConstraints = [toast.topAnchor.constraint(equalTo: vc.view.bottomAnchor),
                            toast.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
                            toast.heightAnchor.constraint(equalToConstant: 65),
                            toast.widthAnchor.constraint(equalTo: vc.view.widthAnchor, multiplier: 0.9)
    ]
    
    
    NSLayoutConstraint.activate(toastConstraints)
    
    vc.view.layoutIfNeeded()
    
    UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear) {
        NSLayoutConstraint.deactivate(toastConstraints)
        NSLayoutConstraint.activate(toastUpConstraints)
        vc.view.layoutIfNeeded()
    } completion: { _ in
        UIView.animate(withDuration: 0.25, delay: delay, options: .curveLinear) {
            NSLayoutConstraint.deactivate(toastUpConstraints)
            NSLayoutConstraint.activate(toastDownConstraints)
            vc.view.layoutIfNeeded()
        } completion: { _ in
            toast.removeFromSuperview()
        }

    }
}
