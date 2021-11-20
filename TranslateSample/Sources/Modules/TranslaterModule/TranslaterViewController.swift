//
//  TranslaterViewController.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 19.11.2021.
//

import UIKit

protocol TranslaterViewProtocol: AnyObject {
    func onTranslateCompletlyFetched(translation: String)
    func errTranslateDataFetched()
    func errNoTranslation()
    func errAuthorization()
}

final class TranslaterViewController: UIViewController {

    // MARK: - Public Properties
    
    public var presenter: TranslaterPresenterProtocol?
    
    // MARK: - Private Properties
    
    private enum Constant {
        static let mainBackgroundColor: UIColor = .mainBackgroundColor
        static let cornerRadius: CGFloat = 8.0
        static let buttonColor: UIColor = .dark
        static let buttonTextColor: UIColor = .mainBackgroundColor
    }
    
    private lazy var inputTextView = InputWordView()
    
    private lazy var outputView = OutputView()
    
    private lazy var translateButton: UIButton = {
        let button = UIButton()
        button.setTitle("TRANSLATE", for: .normal)
        button.addTarget(self, action: #selector(translate(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constant.cornerRadius
        button.backgroundColor = Constant.buttonColor
        button.setTitleColor(Constant.buttonTextColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    // MARK: - LIfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        title = "Translater"
        view.addSubview(inputTextView)
        view.addSubview(translateButton)
        view.addSubview(outputView)
        view.backgroundColor = Constant.mainBackgroundColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "history_logo"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openHistory(_:)))
    }
    
    private func setupConstraints() {
        let inputTextConstraints = [inputTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                                   inputTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                                   inputTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                   inputTextView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4)]
        
        let translateButtonConstraints = [translateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                          translateButton.widthAnchor.constraint(equalToConstant: 200),
                                          translateButton.topAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: 20),
                                          translateButton.heightAnchor.constraint(equalToConstant: 60)]
        
        let outputTextConstraints = [outputView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                                    outputView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                                    outputView.topAnchor.constraint(equalTo: translateButton.bottomAnchor, constant: 20),
                                    outputView.heightAnchor.constraint(equalToConstant:  UIScreen.main.bounds.height / 4)]
        
        
        NSLayoutConstraint.activate(inputTextConstraints)
        NSLayoutConstraint.activate(translateButtonConstraints)
        NSLayoutConstraint.activate(outputTextConstraints)
    }
    
    // MARK: - Actions
    
    @objc
    private func openHistory(_ sender: UIButton) {
        presenter?.historyButtonDidTapped()
    }
    
    @objc
    private func translate(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.autoreverse]) {
            sender.alpha = 0.7
        } completion: { _ in
            sender.alpha = 1.0
        }
        view.endEditing(true)
        presenter?.sendRequest(with: inputTextView.text)
    }
}

// MARK: - TranslaterView

extension TranslaterViewController: TranslaterViewProtocol {
    func errNoTranslation() {
        showToast(message: "word or dictionary not found", vc: self)
    }
    
    func errTranslateDataFetched() {
        showToast(message: "internal error", vc: self)
    }
    
    func onTranslateCompletlyFetched(translation: String) {
        outputView.text = translation
    }
    
    func errAuthorization() {
        showToast(message: "authorizationn error", vc: self)
    }
}
