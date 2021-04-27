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
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var addNumberButton: UIButton!
    @IBOutlet private var callButton: UIButton!
    @IBOutlet private var deleteButton: UIButton!
    @IBOutlet var buttons: [UIButton]!
    
    private var addNewContactButton: UIButton!
    private var backgrountButtonViews: [String: UIView] = [:]
    private let charsUnderNum: [String:String] = [
        "0": "+"   , "1": "" ,
        "2": "ABC" , "3": "DEF" ,
        "4": "GHI" , "5": "JKL" ,
        "6": "MNO" , "7": "PQRS",
        "8": "TUV" , "9": "WXYZ"
    ]
    
    private let customGreenColor = UIColor(hex: "#00CD46")
    private let customGrayColor = UIColor(hex: "#E0E0E0")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons.forEach {
            if charsUnderNum.keys.contains($0.titleLabel!.text!) {
                createbackgroundButtonView($0)
            } else {
                makeButtonRounded($0)
                $0.backgroundColor = customGrayColor
            }
            $0.addTarget(self, action: #selector(pressedNumber), for: .touchUpInside)
        }
        deleteButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside)
        makeButtonRounded(callButton)
    }
    
    private func makeViewRounded(_ view: UIView) {
        view.layer.cornerRadius = 0.5 * view.frame.width
        view.clipsToBounds = true
    }
    
    private func makeButtonRounded(_ button: UIButton) {
        button.layer.cornerRadius = 0.5 * button.frame.height
        button.clipsToBounds = true
    }
    
    private func createLabel(_ rect: CGRect, _ text: String, _ size: CGFloat) -> UILabel {
        let label = UILabel(frame: rect)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .black
        label.text = text
        label.font = UIFont(name: "Helvetica" , size: size)
        return label
    }
    
    private func createbackgroundButtonView(_ button: UIButton) {
        let buttonLabelsView = UIView(frame: button.bounds)
        buttonLabelsView.backgroundColor = customGrayColor
        makeViewRounded(buttonLabelsView)
        
        let buttonNum = button.titleLabel!.text!
        
        let labelNumFrame = CGRect(x: button.bounds.minX,
                                   y: button.bounds.minY + 2 / 9 * button.bounds.width,
                                   width: button.bounds.width,
                                   height: 4 / 9 * button.bounds.width)
        let labelCharsFrame = CGRect(x: button.bounds.minX ,
                                     y: button.bounds.minY + 6 / 9 * button.bounds.width,
                                     width: button.bounds.width,
                                     height: 1 / 9 * button.bounds.width)
        
        let labelNum = createLabel(labelNumFrame, buttonNum, 40)
        let labelChars = createLabel(labelCharsFrame, charsUnderNum[buttonNum]!, 10)
        
        buttonLabelsView.addSubview(labelChars)
        buttonLabelsView.addSubview(labelNum)
        
        button.addSubview(buttonLabelsView)
        buttonLabelsView.isUserInteractionEnabled = false
        
        backgrountButtonViews["\(buttonNum)"] = buttonLabelsView
    }
    
    private func toggleAddButtonAppearance() {
        let title = addNumberButton.isEnabled ? "" : "Add Number"
        addNumberButton.setTitle(title, for: .normal)
        addNumberButton.isEnabled.toggle()
    }
    
    private func toggleDeleteButtonAppearance() {
        deleteButton.isHidden.toggle()
        deleteButton.isEnabled.toggle()
    }
    
    private func changeGrayColorForSec(_ num: String) {
        UIView.animate(withDuration: 1) {
            self.backgrountButtonViews[num]?.backgroundColor = .darkGray
            self.backgrountButtonViews[num]?.backgroundColor = self.customGrayColor
        }
    }
    
    private func changeGrayColorForSec(_ button: UIButton) {
        UIView.animate(withDuration: 1) {
            button.backgroundColor = .darkGray
            button.backgroundColor = self.customGrayColor
        }
    }
    
    @objc func pressedNumber(_ sender: UIButton) {
        let newChar = sender.titleLabel!.text!
        
        if newChar == "*" || newChar == "#" {
            changeGrayColorForSec(sender)
        } else {
            changeGrayColorForSec(newChar)
        }
        
        numberLabel.text?.append(newChar)
        let num = numberLabel.text!
        if num.count == 1 {
            toggleAddButtonAppearance()
            toggleDeleteButtonAppearance()
        } else if (num.count == 3 || num.count == 7 && num.first! == "0") ||
                    (num.count == 3 && num.first! != "0" && num.first! != "+") {
            numberLabel.text?.append(" ")
        }
    }
    
    @objc func pressedBack(_ sender: UIButton) {
        if !numberLabel.text!.isEmpty {
            numberLabel.text!.removeLast()
            if numberLabel.text!.isEmpty {
                toggleAddButtonAppearance()
                toggleDeleteButtonAppearance()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "startConversation" {
            let conversationViewController = segue.destination as! ConversationViewController
            conversationViewController.modalPresentationStyle = .overFullScreen
            conversationViewController.number = numberLabel.text
        }
    }
    
    @IBAction func pressedCallButton(_ sender: UIButton) {
    }
    
    @IBAction  func addNumber(_ sender: UIButton) {
    }
    
}
    

