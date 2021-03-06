import UIKit

class CallCell: UITableViewCell {
    @IBOutlet var isMissedIcon: UIImageView!
    @IBOutlet var contactNameLabel: UILabel!
    @IBOutlet var numberMissedCallsLabel: UILabel!
    @IBOutlet var typeCallLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
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
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()
    
    let oneWeekTime: Double = -60 * 60 * 24 * 7
    
    private func formateDate(call: Call) -> String {
        if Calendar.current.isDateInToday(call.date) {
            return timeDateFormatter.string(from: call.date)
        } else if Calendar.current.isDateInYesterday(call.date) {
            return "Yesterday"
        } else if Date(timeIntervalSinceNow: oneWeekTime) < call.date {
            return fullDateFormatter.string(from: call.date)
        } else { 
            return mediumDateFormatter.string(from: call.date)
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
