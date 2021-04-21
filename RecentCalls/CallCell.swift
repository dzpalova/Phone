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
        let date = call.date
        let nameDayOfWeek = fullDateFormatter.string(from: date)
        let nameOfToday = fullDateFormatter.string(from: Date())
        
        if nameDayOfWeek == nameOfToday {
            return timeDateFormatter.string(from: date)
        } else if Date(timeIntervalSinceNow: oneWeekTime) < date {
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
