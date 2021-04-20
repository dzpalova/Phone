import UIKit

enum TypeCall: String, Codable {
    case mobile
    case faceTimeAudio = "FaceTime Audio"
    case other
}

class Call: Codable {
    var contactName: String
    var type: TypeCall
    var date: String
    var numCalls: Int
    var isMissed: Bool
    var isOutcome: Bool
    
    enum CodingKeys: String, CodingKey {
        case contactName = "name"
        case type = "source"
        case numCalls = "count"
        case date
        case isMissed
        case isOutcome
    }
    
    init(contactName: String, numCalls: Int, type: TypeCall, date: String,
         isMissed: Bool, isOutgoing: Bool) {
        self.contactName = contactName
        self.numCalls = numCalls
        self.type = type
        self.date = date
        self.isMissed = isMissed
        self.isOutcome = isOutgoing
    }
}

class CallStore {
    var allCalls: [Call]
    var missedCalls: [Call] {
        return allCalls.filter { $0.isMissed }
    }

    init() {
        allCalls = [Call]()
        do {
            if let path = Bundle.main.url(forResource: "calls", withExtension: "json") {
                let jsonData = try Data(contentsOf: path)
                allCalls = try JSONDecoder().decode([Call].self, from: jsonData)
            }
        } catch {
            print("Error decoding allItems: \(error)")
        }
    }
    
    func callsCount() -> Int {
        return allCalls.count
    }
    
    func getCall(at indexPath: IndexPath) -> Call {
        return allCalls[indexPath.row]
    }
    
    func missedCallsCount() -> Int {
        return missedCalls.count
    }
    
    func getMissedCall(at indexPath: IndexPath) -> Call {
        return missedCalls[indexPath.row]
    }
    
    func removeCall(at idx: IndexPath) {
        allCalls.remove(at: idx.row)
    }
    
    func removeMissedCall(at idx: IndexPath) {
        var count = 0
        for i in 0 ..< allCalls.count {
            if allCalls[i].isMissed {
                if count == idx.row {
                    allCalls.remove(at: i)
                    break
                }
                count += 1
            }
        }
    }
    
    func deleteAll() {
        allCalls = []
    }
}
