//
//  ArrayTableViewCell.swift
//  programmingPractice
//
//  Created by Christian on 4/10/18.
//  Copyright © 2018 Gridstone. All rights reserved.
//

import UIKit

class ArrayTableViewCell: UITableViewCell {

    let textField = UITextField()
    let button = UIButton()
    var delegate: CellDelegate?
    var index = 0

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textField.placeholder = "num1, num2, num3 etc."

        button.setTitle("Submit", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)

        for view in [textField, button] as! [UIView] {

            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
        }

        NSLayoutConstraint.activate([

            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -32),
            textField.heightAnchor.constraint(equalToConstant: 44),

            button.topAnchor.constraint(equalTo: textField.topAnchor),
            button.leadingAnchor.constraint(greaterThanOrEqualTo: textField.trailingAnchor, constant: 8),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 44)
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonHandler() {

        let text = textField.text!
        let numbers = stringToArray(string: text)
        delegate?.handleArray(array: numbers, index: self.index)
    }

    func stringToArray(string: String) -> [Int] {

        var numbers = [Int]()
        var temp = ""

        for char in string {

            let strChar:String = "\(char)"
            switch strChar {

            case ",", ".", " " :

                guard let number = Int(temp) else {continue}
                numbers.append(number)
                temp = ""
            default:
                temp += strChar
            }

            if char == string.last {
                guard let number = Int(temp) else {continue}
                numbers.append(number)
            }
        }

        return numbers
    }

}
