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
    var presentedTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        label.textColor = .black
        label.textAlignment = .center
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "customCell")
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        
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
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let window = UIApplication.shared.keyWindow else { return }
        guard let presentedTextField = self.presentedTextField else { return }

        let keyboardPoint = window.convert(keyboardFrame.cgRectValue.origin, to: view)
        let textFieldHeight = presentedTextField.frame.origin.y + presentedTextField.frame.size.height
        let textFieldPoint = presentedTextField.convert(CGPoint(x: 0.0, y: textFieldHeight), to: view)

        if textFieldPoint.y >= keyboardPoint.y {
            tableView.contentOffset.y += keyboardFrame.cgRectValue.height
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        //tableView.contentOffset.y -= tableView.frame.origin.y
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
        cell.textField1.delegate = self
        cell.textField2.delegate = self
        
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
        case .palindrome:
            cell.style = CellStyle.textInput
        case .primeNumbers:
            cell.style = CellStyle.singleInput
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
                guard let number = Int(temp) else {break}
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
            if let values = validateInts(v1: value1, v2: value2) {
                label.text = addition(value1: values.0, value2: values.1)
            }
        case .multiplication:
            if let values = validateInts(v1: value1, v2: value2) {
                label.text = multiply(value1: values.0, value2: values.1)
            }
        case .counting:
            if let v1 = validateInt(v1: value1) {
                label.text = countToV1(value: v1)
            }
        case.factorial:
            if let v1 = validateDouble(v1: value1) {
                label.text = factorialOf(value: v1)
            }
        case .evenNumbers:
            if let array = validateArray(v1: value1) {
                label.text = returnEvenNumbers(array: array)
            }
        case .largestNumber:
            if let array = validateArray(v1: value1) {
                label.text = returnLargestNumber(array: array)
            } 
        case .palindrome:
                label.text = palindrome(value: value1)
        case .primeNumbers:
            if let v1 = validateInt(v1: value1) {
                label.text = primeNumberChecker(value: Int(v1))
            }
        }
    }

    func validateDouble(v1: String) ->Double? {
        if let v1 = Double(v1) {
            return v1
        }
        label.text = "Invalid number"
        return nil
    }
    func validateInt(v1: String) ->Int? {
        if let v1 = Int(v1) {
            return v1
        }
        label.text = "Invalid number"
        return nil
    }
    func validateInts(v1: String, v2: String?) ->(Int,Int)? {
        if let v1 = Int(v1), let temp = v2, let val2 = Int(temp) {
            return (v1, val2)
        }
        label.text = "Invalid number"
        return nil
    }

    func validateArray(v1: String) -> [Int]? {

        let array = stringToArrayOfInt(string: v1)
        if array.count == 0 {
            label.text = "No numbers input or invalid input"
            return nil
        }
        return array
    }
}

extension MainViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.presentedTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        self.presentedTextField = nil
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
    case palindrome
    case primeNumbers
    
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
            return "Factorial of: "
        case .evenNumbers:
            return "Even numbers in: "
        case .largestNumber:
            return "Largest number in: "
        case .palindrome:
            return "Palindrome: "
        case .primeNumbers:
            return "Prime numbers: "
        }
        
    }
    
    static var count: Int = 9
}
