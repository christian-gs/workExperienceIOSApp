func yourCode() -> String {

    return " jack "
}

//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        let textField = UITextField()
        let button = UIButton()

        label.text = "Enter Your Name"
        label.textColor = .black
        label.textAlignment = .center


        button.setTitle("enter", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)

        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 44),

            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.6),

            button.topAnchor.constraint(equalTo: textField.topAnchor),
            button.leadingAnchor.constraint(equalTo: textField.trailingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])





        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
PlaygroundPage.current.needsIndefiniteExecution = true

