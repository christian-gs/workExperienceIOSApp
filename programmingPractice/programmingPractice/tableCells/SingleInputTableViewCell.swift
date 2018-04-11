//
//  SingleInputTableViewCell.swift
//  programmingPractice
//
//  Created by Christian on 4/10/18.
//  Copyright © 2018 Gridstone. All rights reserved.
//

import UIKit

class SingleInputTableViewCell: UITableViewCell {

    let textField = UITextField()
    let button = UIButton()
    var delegate: CellDelegate?
    var index = 0

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)



        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.placeholder = "num"
        textField.keyboardType = .numberPad

        button.setTitle("Submit", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)

        textField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textField)
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)

        NSLayoutConstraint.activate([

            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textField.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.6),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            button.topAnchor.constraint(equalTo: textField.topAnchor),
            button.leadingAnchor.constraint(greaterThanOrEqualTo: textField.trailingAnchor, constant: 8),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonHandler() {

        delegate?.handle1Value(value: textField.text!, index: self.index)
    }

}
