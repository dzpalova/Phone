//
//  KeypadViewController.swift
//  RecentCalls
//
//  Created by Daniela Palova on 23.04.21.
//

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        if hex.first != "#" || hex.count != 7 && hex.count != 9 {
            return nil
        }
        guard let valueR = Int(hex.prefix(3).suffix(2), radix: 16),
              let valueG = Int(hex.prefix(5).suffix(2), radix: 16),
              let valueB = Int(hex.prefix(7).suffix(2), radix: 16) else {
            return nil
        }

        let redVal = CGFloat(valueR)
        let greenVal = CGFloat(valueG)
        let blueVal = CGFloat(valueB)
        var alphaVal: CGFloat = 255
        if hex.count == 9 {
            if let valueA = Int(hex.prefix(3).suffix(2), radix: 16) {
                alphaVal = CGFloat(valueA)
            }
        }
        self.init(red: redVal / 255, green: greenVal / 255, blue: blueVal / 255, alpha: alphaVal / 255)
    }
}

class KeypadViewController: UIViewController {
    private var numberLabel: UILabel!
    private var callButton: UIButton!
    private var addNewContactButton: UIButton!
    private var deleteButton: UIButton!
    
    private var buttons = [String: UIButton]()
    
    private let customGreenColor = UIColor(hex: "#00CD46")
    private let customGrayColor = UIColor(hex: "#E0E0E0")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createKeypad()
    }
    
    private func makeButtonRounded(_ button: UIButton) {
        button.layer.cornerRadius = 0.5 * button.frame.height
        button.layer.borderWidth = button.frame.height * 0.1
        button.clipsToBounds = true
        button.layer.borderColor = view.backgroundColor?.cgColor
    }
    private func makeViewRounded(_ view: UIView) {
        view.layer.cornerRadius = 0.5 * view.frame.height
        view.layer.borderWidth = view.frame.height * 0.1
        view.clipsToBounds = true
        view.layer.borderColor = view.backgroundColor?.cgColor
    }
    
    @discardableResult func createNumButton(_ rect: CGRect, _ numText: String, _ charsText: String) -> UIButton {
        let button = UIButton(frame: rect)
        
        button.backgroundColor = .clear
        makeButtonRounded(button)
        
        button.setTitle(numText, for: .normal)
        button.setTitleColor(.clear, for: .normal)
        
        let buttonLabelsView = UIView(frame: rect)
        buttonLabelsView.backgroundColor = customGrayColor
        makeViewRounded(buttonLabelsView)
        
        let labelNumFrame = CGRect(x: button.bounds.minX, y: button.bounds.minY + 2 / 9 * button.bounds.height,
                                   width: button.bounds.width, height: 4/9 * button.bounds.height)
        let labelNum = UILabel(frame: labelNumFrame)
        labelNum.textAlignment = .center
        labelNum.backgroundColor = .clear
        labelNum.textColor = .black
        labelNum.text = numText
        labelNum.font = UIFont(name: "Helvetica" , size: 40)
        
        let labelCharsFrame = CGRect(x: button.bounds.minX, y: button.bounds.minY + 6 / 9 * button.bounds.height,
                                     width: button.bounds.width, height: 1 / 9 * button.bounds.height)
        let labelChars = UILabel(frame: labelCharsFrame)
        labelChars.textAlignment = .center
        labelChars.backgroundColor = .clear
        labelChars.textColor = .black
        labelChars.text = charsText
        labelChars.font = UIFont(name: "Helvetica" , size: 10)
        
        buttonLabelsView.addSubview(labelChars)
        buttonLabelsView.addSubview(labelNum)

        view.addSubview(buttonLabelsView)
        view.addSubview(button)
        button.addTarget(self, action: #selector(pressedNumber), for: .touchUpInside)
        buttons[numText] = button
        
        return button
    }
    
    private func createKeypad() {
        let offsetX: CGFloat = 40
        let backgroundViewFrame = CGRect(x: view.frame.minX + offsetX, y: view.frame.minY + 20, width: view.frame.width - 2 * offsetX, height: view.frame.height - 100)
        let backgroundView = UIView(frame: backgroundViewFrame)
        
        numberLabel = UILabel()
        numberLabel.text = ""
        numberLabel.backgroundColor = .clear
        numberLabel.textColor = .black
        numberLabel.textAlignment = .center
        numberLabel.font = UIFont(name: "Helvetica" , size: 70)
        view.addSubview(numberLabel)
        
        let size: CGFloat = backgroundView.frame.width / 3

        // row 1
        var buttonY = backgroundViewFrame.height - size
        var r = CGRect(x: offsetX, y: buttonY, width: size, height: size)
        createNumButton(r, "", "").backgroundColor = view.backgroundColor
        
        r = CGRect(x: offsetX + size, y: buttonY, width: size, height: size)
        callButton = UIButton(frame: r)
        callButton.backgroundColor = customGreenColor
        makeButtonRounded(callButton)
        let phoneView = UIImageView(frame: CGRect(x: r.minX + 1 / 3 * r.width, y: r.minY + 1 / 3 * r.height, width: 1 / 3 * r.width, height: 1 / 3 * r.height))
        phoneView.image = UIImage(systemName: "phone.fill")
        phoneView.tintColor = .white
        callButton.addTarget(self, action: #selector(pressedCallButton), for: .touchUpInside)
        view.addSubview(callButton)
        view.addSubview(phoneView)

        r = CGRect(x: offsetX + size * 2, y: buttonY, width: size, height: size)
        deleteButton = UIButton(frame: r)
        deleteButton.backgroundColor = .clear
        makeButtonRounded(deleteButton)
        
        let backButtonView = UIImageView(frame: CGRect(x: r.minX + 1 / 3 * r.width, y: r.minY + 1 / 3 * r.height, width: 1 / 3 * r.width, height: 1 / 3 * r.height))
        backButtonView.image = UIImage(systemName: "delete.left.fill")
        backButtonView.tintColor = customGrayColor
        deleteButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside)
        view.addSubview(backButtonView)
        view.addSubview(deleteButton)
        
        
        //row 2
        buttonY -= size
        r = CGRect(x: offsetX, y: buttonY, width: size, height: size)
        let button1 = UIButton(frame: r)
        button1.backgroundColor = customGrayColor
        makeButtonRounded(button1)
        button1.setTitle("*", for: .normal)
        button1.titleLabel?.font = UIFont(name: "Helvetica" , size: 40)
        button1.setTitleColor(.black, for: .normal)
        button1.addTarget(self, action: #selector(pressedNumber), for: .touchUpInside)
        buttons["*"] = button1
        view.addSubview(button1)
        
        r = CGRect(x: offsetX + size, y: buttonY, width: size, height: size)
        createNumButton(r, "0", "+")
        r = CGRect(x: offsetX + size * 2, y: buttonY, width: size, height: size)
        let button2 = UIButton(frame: r)
        button2.backgroundColor = customGrayColor
        makeButtonRounded(button2)
        button2.setTitle("#", for: .normal)
        button2.titleLabel?.font = UIFont(name: "Helvetica" , size: 40)
        button2.setTitleColor(.black, for: .normal)
        button2.addTarget(self, action: #selector(pressedNumber), for: .touchUpInside)
        buttons["#"] = button2
        view.addSubview(button2)
        
        //row 3
        buttonY -= size
        r = CGRect(x: offsetX, y: buttonY, width: size, height: size)
        createNumButton(r, "7", "P Q R S")
        r = CGRect(x: offsetX + size, y: buttonY, width: size, height: size)
        createNumButton(r, "8", "T U V")
        r = CGRect(x: offsetX + size * 2, y: buttonY, width: size, height: size)
        createNumButton(r, "9", "W X Y Z")
        
        //row 4
        buttonY -= size
        r = CGRect(x: offsetX, y: buttonY, width: size, height: size)
        createNumButton(r, "4", "G H I")
        r = CGRect(x: offsetX + size, y: buttonY, width: size, height: size)
        createNumButton(r, "5", "J K L")
        r = CGRect(x: offsetX + size * 2, y: buttonY, width: size, height: size)
        createNumButton(r, "6", "M N O")
        
        //row 5
        buttonY -= size
        r = CGRect(x: offsetX, y: buttonY, width: size, height: size)
        createNumButton(r, "1", "")
        r = CGRect(x: offsetX + size, y: buttonY, width: size, height: size)
        createNumButton(r, "2", "A B C")
        r = CGRect(x: offsetX + size * 2, y: buttonY, width: size, height: size)
        createNumButton(r, "3", "D E F")
        
        numberLabel.frame = CGRect(x: backgroundView.frame.minX, y: backgroundView.frame.minY + 1/3 * buttonY,
                                   width: backgroundView.frame.width, height: 1 / 3 * buttonY)
        
        let addNewContFrame = CGRect(x: numberLabel.frame.minX, y: numberLabel.frame.minY + 1/3 * buttonY,
                                     width: numberLabel.frame.width, height: 1 / 2 * numberLabel.frame.height)
        addNewContactButton = UIButton(frame: addNewContFrame)
        addNewContactButton.setTitleColor(.systemBlue, for: .normal)
        addNewContactButton.isEnabled = false
        addNewContactButton.titleLabel?.textAlignment = .center
        addNewContactButton.addTarget(self, action: #selector(addNumber), for: .touchUpInside)
        view.addSubview(addNewContactButton)
        
    }
    
    private func toggleAddButtonAppearance() {
        let title = addNewContactButton.isEnabled ? "" : "Add Number"
        addNewContactButton.setTitle(title, for: .normal)
        addNewContactButton.isEnabled.toggle()
    }
    
    private func changeGrayColorForSec(_ num: String) {
        UIView.animate(withDuration: 1) { }
    }
    
    @objc func pressedNumber(_ sender: UIButton) {
        let newChar = sender.titleLabel!.text!
        changeGrayColorForSec(newChar)
        numberLabel.text?.append(newChar)
        if numberLabel.text!.count == 1 {
            toggleAddButtonAppearance()
        }
    }
    
    @objc func pressedBack(_ sender: UIButton) {
        if !numberLabel.text!.isEmpty {
            numberLabel.text!.removeLast()
            if numberLabel.text!.isEmpty {
                toggleAddButtonAppearance()
            }
        }
    }
    
    @objc func pressedCallButton(_ sender: UIButton) {
    }
    
    @objc func addNumber(_ sender: UIButton) {
    }
}
    

