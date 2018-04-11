//
//  YourNameViewController.swift
//  programmingPractice
//
//  Created by Christian on 4/5/18.
//  Copyright © 2018 Gridstone. All rights reserved.
//

import UIKit

protocol CellDelegate {
    func helloName(value: String)
    func handle1Value(value: String, index: Int)
    func handle2Values(value1: String, value2: String, index: Int)
    func handleArray(array: [Int], index: Int)
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let label = UILabel()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        label.textColor = .black
        label.textAlignment = .center

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HelloWorldTableViewCell.self, forCellReuseIdentifier: "helloWorldCell")
        tableView.register(DoubleInputTableViewCell.self, forCellReuseIdentifier: "doubleCell")
        tableView.register(SingleInputTableViewCell.self, forCellReuseIdentifier: "singleCell")
        tableView.register(ArrayTableViewCell.self, forCellReuseIdentifier: "arrayCell")

        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([

            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 88),

            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)

    }

    func viewDidDisappear() {
        NotificationCenter.default.removeObserver(self)
    }

    var keyIsBoardVisible = false
    var keyboardHeight: CGFloat = 0.0

    @objc func keyboardWillShow(_ notification: NSNotification) {

        guard !(self.keyIsBoardVisible) else {return}
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        self.keyboardHeight = keyboardFrame.cgRectValue.height

        tableView.contentOffset.y += keyboardHeight
        self.keyIsBoardVisible = true
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {

        guard self.keyIsBoardVisible else {return}
        tableView.contentOffset.y -= self.keyboardHeight
        self.keyIsBoardVisible = false

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 7

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {

        case 1:
            return "Addition "
        case 2:
            return "Multiplication "
        case 3:
            return "Count To: "
        case 4:
            return"Factorial of: "
        case 5:
            return"Even numbers in: "
        case 6:
            return"Largest number in: "
        default:
            return "Hello 'Name' "
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "doubleCell") as! DoubleInputTableViewCell
            cell.delegate = self
            cell.index = 1
            cell.label.text = "+"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "doubleCell") as! DoubleInputTableViewCell
            cell.delegate = self
            cell.index = 2
            cell.label.text = "x"
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "singleCell") as! SingleInputTableViewCell
            cell.delegate = self
            cell.index = 3
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "singleCell") as! SingleInputTableViewCell
            cell.delegate = self
            cell.index = 4
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "arrayCell") as! ArrayTableViewCell
            cell.delegate = self
            cell.index = 5
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "arrayCell") as! ArrayTableViewCell
            cell.delegate = self
            cell.index = 6
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "helloWorldCell") as! HelloWorldTableViewCell
            cell.delegate = self
            return cell
        }

    }
}

extension MainViewController: CellDelegate {

    func helloName(value: String) {

        if value == "" {
            label.text = "Hello World"
        } else {
            label.text = "Hello \(value)"
        }
    }

    func handle1Value(value: String, index: Int) {

        if let number = Double(value) {

            var result = ""
            switch index {

            case 3:
                result = countToV1(value: Int(number))
            case 4:
                result = factorialOf(value: number)
            default:
                result = countToV2(value: Int(number))
            }
            label.text = result

        } else {

            label.text = "Invalid number"
        }
    }

    func handle2Values(value1: String, value2: String, index: Int) {

        if let v1 = Int(value1), let v2 = Int(value2) {

            var result = ""
            switch index {

            case 1:
                result = addition(value1: v1, value2: v2)
            case 2:
                result = multiply(value1: v1, value2: v2)
            default:
                result = addition(value1: v1, value2: v2)
            }
            label.text = result

        } else {

            label.text = "Invalid Number"
        }
    }

    func handleArray(array: [Int], index: Int) {

        if array.count == 0 {
            label.text = "No numbers input"
        } else {

            var result = ""
            switch index {

            case 5:
                result = returnEvenNumbers(array: array)
            case 6:
                result = returnLargestNumber(array: array)
            default:
                result = returnEvenNumbers(array: array)
            }
            label.text = result
        }
    }

}
