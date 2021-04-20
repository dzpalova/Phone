//
//  CallStore.swift
//  RecentCalls
//
//  Created by Daniela Palova on 16.04.21.
//

import UIKit

enum TypeCall: String {
    case mobile
    case faceTimeAudio
    case other
}

class Call {
    var contactName: String
    var numCalls: Int
    var type: TypeCall
    var date: Date
    var isMissed: Bool
    var isOutgoing: Bool
    
    init(contactName: String, numCalls: Int, type: TypeCall, date: Date, isMissed: Bool, isOutgoing: Bool) {
        self.contactName = contactName
        self.numCalls = numCalls
        self.type = type
        self.date = date
        self.isMissed = isMissed
        self.isOutgoing = isOutgoing
    }
}

class CallStore {
    var allCalls = [Call]()
    var missedCalls: [Call] {
        return allCalls.filter { $0.isMissed }
    }
    
    let arr = [
        ("Emi", 2, TypeCall.mobile, "2021.04.19 12:50", false, true),
        ("Svetli", 1, TypeCall.mobile, "2021.04.19 12:33", false, true),
        ("Miki", 3, TypeCall.faceTimeAudio, "2021.04.19 11:02", true, false),
        ("Mitko", 2, TypeCall.mobile, "2021.04.19 10:40", false, true),
        ("Gosho", 1, TypeCall.mobile, "2021.04.18 13:49", true, false),
        ("Emi", 1, TypeCall.mobile, "2021.04.18 12:44", false, false),
        ("Mitko", 3, TypeCall.faceTimeAudio, "2021.04.18 10:33", false, true),
        ("Gosho", 2, TypeCall.mobile, "2021.04.17 19:55", true, false),
        ("Emi", 1, TypeCall.mobile, "2021.04.17 15:49", false, false),
        ("Svetli", 3, TypeCall.mobile, "2021.04.15 14:34", false, false),
        ("Miki", 2, TypeCall.faceTimeAudio, "2021.04.15 13:43", true, false),
        ("Mitko", 1, TypeCall.mobile, "2021.04.10 16:44", false, false),
        ("Gosho", 1, TypeCall.mobile, "2021.04.10 10:33", true, false),
        ("Emi", 1, TypeCall.mobile, "2021.04.10 20:58", false, true),
        ("Mitko", 1, TypeCall.faceTimeAudio, "2021.04.05 17:12", false, false),
        ("Gosho", 1, TypeCall.mobile, "2021.04.05 18:48", true, false)
    ]
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        for el in arr {
            let call = Call(contactName: el.0,
                            numCalls: el.1,
                            type: el.2,
                            date: dateFormatter.date(from: el.3)!,
                            isMissed: el.4, isOutgoing: el.5)
            allCalls.append(call)
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

    func deleteAllMissed() {
        allCalls.removeAll { $0.isMissed }
    }
}

//import UIKit
//
//enum TypeCall: String {
//    case mobile
//    case faceTimeAudio
//    case other
//}
//
//class Call {
//    var contactName: String
//    var numCalls: Int
//    var type: TypeCall
//    var date: Date
//    var isMissed: Bool
//    var isOutgoing: Bool
//
//    init(contactName: String, numCalls: Int, type: TypeCall, date: Date, isMissed: Bool, isOutgoing: Bool) {
//        self.contactName = contactName
//        self.numCalls = numCalls
//        self.type = type
//        self.date = date
//        self.isMissed = isMissed
//        self.isOutgoing = isOutgoing
//    }
//}
//
//class CallStore {
//    var allCalls = [[Call](), [Call]()]
//
//    let arr = [
//        ("Emi", 1, TypeCall.mobile, "1996.12.19", false, false),
//        ("Svetli", 1, TypeCall.mobile, "1996.12.19", false, true),
//        ("Miki", 1, TypeCall.faceTimeAudio, "1996.12.19", true, false),
//        ("Mitko", 1, TypeCall.mobile, "1996.12.19", false, true),
//        ("Gosho", 1, TypeCall.mobile, "1996.12.19", true, false),
//        ("Emi", 1, TypeCall.mobile, "1996.12.19", false, false),
//        ("Mitko", 1, TypeCall.faceTimeAudio, "1996.12.19", false, true),
//        ("Gosho", 1, TypeCall.mobile, "1996.12.19", true, true),
//        ("Emi", 1, TypeCall.mobile, "1996.12.19", false, false),
//        ("Svetli", 1, TypeCall.mobile, "1996.12.19", false, false),
//        ("Miki", 1, TypeCall.faceTimeAudio, "1996.12.19", true, false),
//        ("Mitko", 1, TypeCall.mobile, "1996.12.19", false, false),
//        ("Gosho", 1, TypeCall.mobile, "1996.12.19", true, false),
//        ("Emi", 1, TypeCall.mobile, "1996.12.19", false, true),
//        ("Mitko", 1, TypeCall.faceTimeAudio, "1996.12.19", false, false),
//        ("Gosho", 1, TypeCall.mobile, "1996.12.19", true, false)
//    ]
//
//    init() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US")
//        dateFormatter.dateFormat = "yyyy.MM.dd"
//        for el in arr {
//            let call = Call(contactName: el.0,
//                            numCalls: el.1,
//                            type: el.2,
//                            date: dateFormatter.date(from: el.3)!,
//                            isMissed: el.4, isOutgoing: el.5)
//            allCalls[0].append(call)
//            if call.isMissed {
//                allCalls[1].append(call)
//            }
//        }
//    }
//
//    func callsCount() -> Int {
//        return allCalls[0].count
//    }
//
//    func getCall(at indexPath: IndexPath) -> Call {
//        return allCalls[0][indexPath.row]
//    }
//
//    func missedCallsCount() -> Int {
//        return allCalls[1].count
//    }
//
//    func getMissedCall(at indexPath: IndexPath) -> Call {
//        return allCalls[1][indexPath.row]
//    }
//
//    func removeCall(at idx: IndexPath) {
//        if allCalls[0].remove(at: idx.row).isMissed {
//            allCalls[1] = allCalls[0].filter { $0.isMissed }
////            var count = 0
////            for i in 0 ..< allCalls[1].count {
////                if allCalls[1][i].isMissed {
////                    if count == idx.row {
////                        allCalls[1].remove(at: i)
////                        break
////                    }
////                    count += 1
////                }
////            }
//        }
//    }
//
//    func removeMissedCall(at idx: IndexPath) {
//        var count = 0
//        for i in 0 ..< allCalls[0].count {
//            if allCalls[0][i].isMissed {
//                if count == idx.row {
//                    allCalls[0].remove(at: i)
//                    break
//                }
//                count += 1
//            }
//        }
//        allCalls[1].remove(at: idx.row)
//    }
//
//    func deleteAll() {
//        allCalls = [[Call](), [Call]()]
//    }
//
//    func deleteAllMissed() {
//        allCalls[1].removeAll()
//        allCalls[0].removeAll { $0.isMissed }
//    }
//}
