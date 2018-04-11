//
//  YourNameViewController.swift
//  programmingPractice
//
//  Created by Christian on 4/5/18.
//  Copyright © 2018 Gridstone. All rights reserved.
//

import UIKit

protocol CellDelegate {
//  func helloName(value: String)
    func handleInput(value1: String, value2: String?, operation: LearningOperation)
//    func handle1Value(value: String, index: Int)
//    func handle2Values(value1: String, value2: String, index: Int)
//    func handleArray(array: [Int], index: Int)
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
        tableView.register(CustomCell.self, forCellReuseIdentifier: "customCell")
        
        
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
        return LearningOperation.count
        
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
}

extension MainViewController: CellDelegate {
    func handleInput(value1: String, value2: String?, operation: LearningOperation) {
        
        switch operation {
        case .helloWorld:
            helloName(value: value1)
        case .addition:
            handle2Values(value1: value1, value2: value2!, operation: operation)
        case .multiplication:
            handle2Values(value1: value1, value2: value2!, operation: operation)
        case .counting:
            handle1Value(value: value1, operation: operation)
        case.factorial:
            handle1Value(value: value1, operation: operation)
        case .evenNumbers:
            let array = stringToArray(string: value1)
            handleArray(array: array, operation: operation)
        case .largestNumber:
            let array = stringToArray(string: value1)
            handleArray(array: array, operation: operation)
        }
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
    
    
    func helloName(value: String) {
        
        if value == "" {
            label.text = "Hello World"
        } else {
            label.text = "Hello \(value)"
        }
    }
    
    func handle1Value(value: String, operation: LearningOperation) {
        
        if let number = Double(value) {
            
            var result = ""
            switch operation {
                
            case .counting:
                result = countToV1(value: Int(number))
            case .factorial:
                result = factorialOf(value: number)
            default:
                result = "error"
            }
            label.text = result
            
        } else {
            
            label.text = "Invalid number"
        }
    }
    
    func handle2Values(value1: String, value2: String, operation: LearningOperation) {
        
        if let v1 = Int(value1), let v2 = Int(value2) {
            
            var result = ""
            switch operation {
                
            case .addition:
                result = addition(value1: v1, value2: v2)
            case .multiplication:
                result = multiply(value1: v1, value2: v2)
            default:
                result = "error"
            }
            label.text = result
            
        } else {
            
            label.text = "Invalid Number"
        }
    }
    
    func handleArray(array: [Int], operation: LearningOperation) {
        
        if array.count == 0 {
            label.text = "No numbers input"
        } else {
            var result = ""
            switch operation {
                
            case .evenNumbers:
                result = returnEvenNumbers(array: array)
            case .largestNumber:
                result = returnLargestNumber(array: array)
            default:
                result = "error"
            }
            label.text = result
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
    
    static var count: Int = 7
}
