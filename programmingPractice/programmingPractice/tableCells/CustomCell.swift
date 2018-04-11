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
        
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        var constraints: [NSLayoutConstraint] = []
        
        switch style {
        case .array:
            textField1.placeholder = "Enter values"
            textField1.keyboardType = .default
        case .singleInput:
            textField1.placeholder = "Enter value"
            textField1.keyboardType = .numberPad
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
        case .textInput:
            textField1.placeholder = "Enter text"
            textField1.keyboardType = .default
        }
        
        if style == .doubleInput {
            
            for view in [textField1, label, textField2, button] as [UIView] {
                
                view.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(view)
            }
            
            constraints += [textField1.topAnchor.constraint(equalTo: contentView.topAnchor),
                            textField1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                            textField1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                            textField1.widthAnchor.constraint(equalToConstant: 34),
                            
                            label.topAnchor.constraint(equalTo: topAnchor),
                            label.leadingAnchor.constraint(equalTo: textField1.trailingAnchor, constant: 4),
                            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                            label.widthAnchor.constraint(equalToConstant: 18),
                            
                            textField2.topAnchor.constraint(equalTo: topAnchor),
                            textField2.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 4),
                            textField2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                            textField2.widthAnchor.constraint(equalToConstant: 34),
            ]
        } else {
            for view in [textField1, button] as [UIView] {
                view.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(view)
            }
            
            constraints += [textField1.topAnchor.constraint(equalTo: contentView.topAnchor),
                            textField1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                            textField1.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -32),
                            textField1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ]
        }
        
        constraints += [button.topAnchor.constraint(equalTo: textField1.topAnchor),
                        button.leadingAnchor.constraint(greaterThanOrEqualTo: textField1.trailingAnchor, constant: 8),
                        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
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
