//
//  HistoryTableViewCell.swift
//  TranslateSample
//
//  Created by Ilya Nesterenko on 20.11.2021.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
