import UIKit
import Foundation

class ContactItems {
    var contacts: Array<Array<String>> = []
    private var existingSections = Set<Character>()
    
    init() {
        for _ in 0..<40 {
            createContact()
        }
    }
    
    @discardableResult func createContact() -> String {
        let name = ["Ani", "Yavor", "Asya", "Aleks", "Eva", "Albena", "Katya", "Bobi", "Stefani", "Kalina", "Vaya", "Viktor", "Vanesa", "Ceco", "Dafi", "Deni", "Angel", "Albena", "Bilqn", "Dori"].randomElement()!
        let firstLetter = name.first!

        if existingSections.contains(firstLetter) {
            var idxSection = 0
            for i in 0 ..< contacts.count {
                if contacts[i].first!.first! == firstLetter {
                    idxSection = i
                    break
                }
            }
                    
            contacts[idxSection].append(name)
            contacts[idxSection].sort()
        } else {
            existingSections.insert(firstLetter)
            contacts.append([name])
            if contacts.count > 2 {
                contacts.sort { $0.first! < $1.first! }
            }
        }
        return name
    }
    
    func rowsInSection(_ section: Int) -> Int {
        return contacts[section].count
    }
    
    func titleSection(_ section: Int) -> String? {
        return contacts[section].count != 0 ? String(contacts[section][0].first!) : nil
    }
}
