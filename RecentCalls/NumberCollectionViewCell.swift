import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
    func setNumberButton(to button: UIButton) {
        //keypadNumberButton.backgroundColor = .clear
        //keypadNumberButton.titleLabel?.isHidden = true
//        keypadNumberButton.setTitle("45", for: .normal)
//        keypadNumberButton.setTitleColor(.white, for: .normal)
//        addSubview(keypadNumberButton)
        backgroundView = button
    }
}
