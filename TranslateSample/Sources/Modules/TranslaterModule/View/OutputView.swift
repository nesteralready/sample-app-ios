//
//  OutputView.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 20.11.2021.
//

import UIKit

final class OutputView: UIView {
    
    // MARK: - Public Properties
    
    public var text: String = "" {
        didSet {
            outputLabel.text = text
        }
    }
    
    // MARK: - Private Properties
    
    private enum Constant {
        static let cornerRadius: CGFloat = 10.0
    }
    
    private lazy var outputLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .clear
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
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
        addSubview(outputLabel)
    }
    
    private func setupConstraints() {
        let inputTextViewConstraints = [outputLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
                                        outputLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
                                        outputLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)]
        
        NSLayoutConstraint.activate(inputTextViewConstraints)
    }
}
