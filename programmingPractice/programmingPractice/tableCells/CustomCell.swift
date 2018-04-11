//
//  additionTableViewCell.swift
//  programmingPractice
//
//  Created by Christian on 4/9/18.
//  Copyright © 2018 Gridstone. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    let textField1 = UITextField()
    let label = UILabel()
    let textField2 = UITextField()
    let button = UIButton()
    var delegate: CellDelegate?
    var operation: LearningOperation?
    var style: CellStyle? {
        didSet{
            setUpCell(forStyle: style!)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        button.setTitle("Submit", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        
        label.textAlignment = .center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonHandler() {
        guard textField1.text != nil && operation != nil else {
            return
        }
        delegate?.handleInput(value1: textField1.text!, value2: textField2.text, operation: self.operation!)
    }
    
    func setUpCell(forStyle style: CellStyle) {
        switch style {
        case .array:
            
            textField1.placeholder = "Enter values"
            textField1.keyboardType = .default
            textField2.placeholder = "num"
            textField2.keyboardType = .numberPad
            
            for view in [textField1, button] as [UIView] {
                
                view.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(view)
            }
            
            NSLayoutConstraint.activate([
                
                textField1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                textField1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                textField1.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -32),
                textField1.heightAnchor.constraint(equalToConstant: 44),
                
                button.topAnchor.constraint(equalTo: textField1.topAnchor),
                button.leadingAnchor.constraint(greaterThanOrEqualTo: textField1.trailingAnchor, constant: 8),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                button.heightAnchor.constraint(equalToConstant: 44)
                ])
            
        case .singleInput:
            
            textField1.placeholder = "Enter value"
            textField1.keyboardType = .numberPad
            
            textField1.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(textField1)
            button.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(button)
            
            NSLayoutConstraint.activate([
                
                textField1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                textField1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                textField1.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.6),
                textField1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                button.topAnchor.constraint(equalTo: textField1.topAnchor),
                button.leadingAnchor.constraint(greaterThanOrEqualTo: textField1.trailingAnchor, constant: 8),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                ])
            
        case .doubleInput:
            
            if operation == .addition {
                label.text = "+"
            } else if operation == .multiplication {
                label.text = "x"
            }
            
            
            textField1.placeholder = "num"
            textField1.keyboardType = .numberPad
            textField2.placeholder = "num"
            textField2.keyboardType = .numberPad
            
            for view in [textField1, label, textField2, button] as [UIView] {
                
                view.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(view)
            }
            
            NSLayoutConstraint.activate([
                
                textField1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                textField1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                textField1.heightAnchor.constraint(equalToConstant: 44),
                textField1.widthAnchor.constraint(equalToConstant: 34),
                
                label.topAnchor.constraint(equalTo: textField1.topAnchor),
                label.leadingAnchor.constraint(equalTo: textField1.trailingAnchor, constant: 4),
                label.heightAnchor.constraint(equalToConstant: 44),
                label.widthAnchor.constraint(equalToConstant: 14),
                
                textField2.topAnchor.constraint(equalTo: textField1.topAnchor),
                textField2.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 4),
                textField2.heightAnchor.constraint(equalToConstant: 44),
                textField2.widthAnchor.constraint(equalToConstant: 34),
                
                button.topAnchor.constraint(equalTo: textField2.topAnchor),
                button.leadingAnchor.constraint(greaterThanOrEqualTo: textField2.trailingAnchor, constant: 8),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                button.heightAnchor.constraint(equalToConstant: 44)
                ])
            
        case .textInput:
            textField1.placeholder = "Enter text"
            textField1.keyboardType = .default
            
            textField1.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(textField1)
            button.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(button)
            
            NSLayoutConstraint.activate([
                
                textField1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                textField1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                textField1.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.6),
                textField1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                button.topAnchor.constraint(equalTo: textField1.topAnchor),
                button.leadingAnchor.constraint(greaterThanOrEqualTo: textField1.trailingAnchor, constant: 8),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                ])
        }
    }

}

enum CellStyle {
    case singleInput
    case doubleInput
    case textInput
    case array
}

protocol CellDelegate: class {
    func handleInput(value1: String, value2: String?, operation: LearningOperation)
}
