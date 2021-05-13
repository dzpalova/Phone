import UIKit

class ConversationViewController: UIViewController {
    @IBOutlet var contact: UILabel!
    @IBOutlet var timer: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var endConversationButton: UIButton!
    var number: String!
    
    private var keypadButtons: KeypadControl!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var hideButton: UIButton!
    
    private let customGrayColor = UIColor(hex: "#E0E0E0")
    
    private func makeButtonRounded(_ button: UIButton) {
        button.layer.cornerRadius = 0.5 * button.frame.height
        button.clipsToBounds = true
    }
    
    @IBAction private func changeView() {
        buttons.forEach { $0.isHidden.toggle() }
        labels.forEach { $0.isHidden.toggle() }
        timer.isHidden.toggle()
        contact.isHidden.toggle()
        keypadButtons.isHidden.toggle()
        numberLabel.isHidden.toggle()
        hideButton.isHidden.toggle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contact.text = number
        buttons.forEach {
            makeButtonRounded($0)
        }
        
        
        let keypadFrame = CGRect(x: view.frame.minX + 40 , y: numberLabel.frame.maxY + 100, width: view.frame.width - 80, height: view.frame.width)
        keypadButtons = KeypadControl(frame: keypadFrame, style: .keypadFromContacts)
        keypadButtons.addTarget(self, action: #selector(buttonPressed), for: .valueChanged)
        keypadButtons.isHidden = true
        view.addSubview(keypadButtons)
        
        numberLabel.isHidden = true
        hideButton.isHidden = true
        makeButtonRounded(endConversationButton)
    }
    
    @IBAction func endConversation(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
        if number.isEmpty {
            return 
        }
        
        let firstEl = SceneDelegate.callStore.getCall(at: IndexPath(row: 0, section: 0))
        if firstEl.contactName != number {
            let call = Call(contactName: number, numCalls: 1, type: TypeCall.mobile, date: Date(), isMissed: false, isOutgoing: true)
            SceneDelegate.callStore.allCalls.insert(call, at: 0)
        } else {
            SceneDelegate.callStore.allCalls[0].numCalls += 1
        }
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(CallStore.dateFormatter)
            let data = try encoder.encode(SceneDelegate.callStore.allCalls)
            try data.write(to: CallStore.callArchiveURL, options: [.atomic])
        } catch {
            print("Error while encoding recent calls: \(error)")
        }
    }
    
    @objc func buttonPressed(_ sender: KeypadControl) {
        numberLabel.text?.append(sender.pressedButton!)
        let num = numberLabel.text!
        if (num.count == 3 || num.count == 7 && num.first! == "0") ||
                    (num.count == 3 && num.first! != "0" && num.first! != "+") {
            numberLabel.text?.append(" ")
        }
    }
}
