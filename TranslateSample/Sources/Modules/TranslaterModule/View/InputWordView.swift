//
//  InputWordView.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 20.11.2021.
//

import Foundation


import UIKit

final class InputWordView: UIView{
    
    // MARK: - Public Properties
    
    public var text: String {
        get {
            return inputTextView.text
        }
    }
    
    // MARK: - Private Properties
    
    private enum Constant {
        static let cornerRadius: CGFloat = 10.0
    }
    
    private lazy var inputTextView: UITextView = {
        let textView = UITextView()
        textView.returnKeyType = .go
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.boldSystemFont(ofSize: 30)
        textView.backgroundColor = .clear
        textView.delegate = self
        return textView
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .inputOutputBackgroundColor
        layer.cornerRadius = Constant.cornerRadius
        addSubview(inputTextView)
    }
    
    private func setupConstraints() {
        let inputTextViewConstraints = [inputTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
                                        inputTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
                                        inputTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
                                        inputTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25)]
        
        NSLayoutConstraint.activate(inputTextViewConstraints)
    }
}

// MARK: - UITextFieldDelegate

extension InputWordView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
