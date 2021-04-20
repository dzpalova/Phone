import UIKit

class CallCell: UITableViewCell {
    @IBOutlet var isMissedIcon: UIImageView!
    @IBOutlet var contactNameLabel: UILabel!
    @IBOutlet var numberMissedCallsLabel: UILabel!
    @IBOutlet var typeCallLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        return dateFormatter
    }()
    
    let timeDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    let mediumDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    let fullDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter
    }()
    
    private func formateDate(call: Call) -> String {
        guard let date = dateFormatter.date(from: call.date) else {
            return dateFormatter.string(from: Date())
        }
        
        let nameDayOfWeek = String(fullDateFormatter.string(from: date).prefix { $0 != "," })
        let nameOfToday = String(fullDateFormatter.string(from: Date()).prefix { $0 != "," })

        if nameDayOfWeek == nameOfToday {
            return timeDateFormatter.string(from: date)
        } else if Date(timeIntervalSinceNow: -60 * 60 * 24 * 7) < date {
            return nameDayOfWeek
        } else { 
            return mediumDateFormatter.string(from: date)
        }
    }
    
    func setCell(with call: Call) {
        contactNameLabel.text = call.contactName
        contactNameLabel.textColor = call.isMissed ? .red : .black
        
        let num = call.numCalls
        numberMissedCallsLabel.text = num > 1 ? "(\(num))" : ""
        numberMissedCallsLabel.textColor = call.isMissed ? .red : .black
        
        typeCallLabel.text = call.type.rawValue
        dateLabel.text = formateDate(call: call)
        isMissedIcon.isHidden = !call.isOutcome
    }
}
