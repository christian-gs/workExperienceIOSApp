//
//  YourNameViewController.swift
//  programmingPractice
//
//  Created by Christian on 4/5/18.
//  Copyright © 2018 Gridstone. All rights reserved.
//

import UIKit

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
        tableView.register(CustomCell.self, forCellReuseIdentifier: "customCell")
        tableView.tableFooterView = UIView()
        
        
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
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        self.keyboardHeight = keyboardFrame.cgRectValue.height
        tableView.contentOffset.y += keyboardHeight
        self.keyIsBoardVisible = true
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        tableView.contentOffset.y -= self.keyboardHeight
        self.keyIsBoardVisible = false
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return LearningOperation.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return LearningOperation(rawValue: section)?.sectionTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let operation = LearningOperation(rawValue: indexPath.section)!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        cell.delegate = self
        cell.operation = operation
        
        switch operation {
        case .helloWorld:
            cell.style = CellStyle.textInput
        case .addition:
            cell.style = CellStyle.doubleInput
        case .multiplication:
            cell.style = CellStyle.doubleInput
        case .counting:
            cell.style = CellStyle.singleInput
        case.factorial:
            cell.style = CellStyle.singleInput
        case .evenNumbers:
            cell.style = CellStyle.array
        case .largestNumber:
            cell.style = CellStyle.array
        }
        return cell
    }
    
    func stringToArrayOfInt(string: String) -> [Int] {
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

extension MainViewController: CellDelegate {
    func handleInput(value1: String, value2: String?, operation: LearningOperation) {
        
        switch operation {
        case .helloWorld:
            if value1 == "" {
                label.text = "Hello World"
            } else {
                label.text = "Hello \(value1)"
            }
        case .addition:
            if let v1 = Int(value1), let value2 = value2, let v2 = Int(value2) {
                label.text = addition(value1: v1, value2: v2)
            } else {
                label.text = "Invalid Number"
            }
        case .multiplication:
            if let v1 = Int(value1), let value2 = value2, let v2 = Int(value2) {
                label.text = multiply(value1: v1, value2: v2)
            } else {
                label.text = "Invalid Number"
            }
        case .counting:
            if let v1 = Double(value1) {
                label.text = countToV1(value: Int(v1))
            } else {
                label.text = "Invalid number"
            }
        case.factorial:
            if let v1 = Double(value1) {
                label.text = factorialOf(value: v1)
            } else {
                label.text = "Invalid number"
            }
        case .evenNumbers:
            let array = stringToArrayOfInt(string: value1)
                if array.count == 0 {
                    label.text = "No numbers input or invalid input"
                } else {
                    label.text = returnEvenNumbers(array: array)
                }
        case .largestNumber:
            let array = stringToArrayOfInt(string: value1)
            if array.count == 0 {
                label.text = "No numbers input or invalid input"
            } else {
                label.text = returnLargestNumber(array: array)
            }
        }
    }
}

enum LearningOperation: Int {
    case helloWorld
    case addition
    case multiplication
    case counting
    case factorial
    case evenNumbers
    case largestNumber
    
    var sectionTitle: String {
        switch self {
        case .helloWorld:
            return "Hello World"
        case .addition:
            return "Addition "
        case .multiplication:
            return "Multiplication "
        case .counting:
            return "Count To: "
        case .factorial:
            return"Factorial of: "
        case .evenNumbers:
            return"Even numbers in: "
        case .largestNumber:
            return"Largest number in: "
        }
    }
    
    static var count: Int = 7
}
