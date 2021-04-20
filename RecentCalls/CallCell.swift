//
//  CallCell.swift
//  RecentCalls
//
//  Created by Daniela Palova on 16.04.21.
//

import UIKit

class CallCell: UITableViewCell {
    @IBOutlet var isMissedIcon: UIImageView!
    @IBOutlet var contactNameLabel: UILabel!
    @IBOutlet var numberMissedCallsLabel: UILabel!
    @IBOutlet var typeCallLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private func formateDate(call: Call) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        
        let dateString = dateFormatter.string(from: call.date)
        if Date(timeIntervalSinceNow: -60*60*24*7) < call.date {
            return String(dateString.prefix { $0 != "," })
        } else {
            var firstIdx = dateString.firstIndex(of: ",")!
            var lastIdx = dateString.lastIndex(of: "a")!
            firstIdx = dateString.index(firstIdx, offsetBy: 2)
            lastIdx = dateString.index(lastIdx,offsetBy: -2)
            return String(dateString[firstIdx...lastIdx])
        }
    }
    
    func setCell(with call: Call) {
        contactNameLabel.text = call.contactName
        contactNameLabel.textColor = call.isMissed ? .red : .black
        
        let num = call.numCalls
        numberMissedCallsLabel.text = num > 1 ? "(\(num))" : ""
        
        typeCallLabel.text = call.type.rawValue
        dateLabel.text = formateDate(call: call)
        isMissedIcon.isHidden = !call.isOutgoing
    }
}
