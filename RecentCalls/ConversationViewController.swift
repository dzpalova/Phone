import UIKit

class ConversationViewController: UIViewController {
    @IBOutlet var contact: UILabel!

    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var endConversationButton: UIButton!
    var number: String!
    
    private func makeButtonRounded(_ button: UIButton) {
        button.layer.cornerRadius = 0.5 * button.frame.height
        button.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contact.text = number
        buttons.forEach {
            makeButtonRounded($0)
        }
        makeButtonRounded(endConversationButton)
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func endConversation() {
        self.dismiss(animated: false, completion: nil)
    }
}
