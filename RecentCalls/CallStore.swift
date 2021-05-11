import UIKit

enum TypeCall: String, Codable {
    case mobile
    case faceTimeAudio = "FaceTime Audio"
    case other
}

class Call: Codable {
    var contactName: String
    var type: TypeCall
    var date: Date
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
    
    init(contactName: String, numCalls: Int, type: TypeCall, date: Date,
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
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        return dateFormatter
    }()
    
    static let callArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("calls.json")
    }()
    
    init() {
        allCalls = [Call]()
        do {
            let jsonData = try Data(contentsOf: CallStore.callArchiveURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(CallStore.dateFormatter)
            allCalls = try decoder.decode([Call].self, from: jsonData)
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

