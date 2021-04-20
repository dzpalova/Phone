import UIKit
import Foundation

struct Contact: Codable {
    let name: String
}

class ContactItems {
    var contacts: [[Contact]]
    private var existingSections = Set<Character>()
    
    private func parseData(_ data: [Contact]) {
        for cont in data {
            let name = cont.name
            let firstLetter = name.first!

            if existingSections.contains(firstLetter) {
                var idxSection = 0
                for i in 0 ..< contacts.count {
                    if contacts[i].first!.name.first! == firstLetter {
                        idxSection = i
                        break
                    }
                }
                        
                contacts[idxSection].append(Contact(name: name))
                contacts[idxSection].sort { $0.name < $1.name }
            } else {
                existingSections.insert(firstLetter)
                contacts.append([Contact(name: name)])
                if contacts.count > 2 {
                    contacts.sort { $0.first!.name < $1.first!.name }
                }
            }
        }
    }
    
    init() {
        contacts = [[Contact]]()
        do {
            if let path = Bundle.main.url(forResource: "contacts", withExtension: "json") {
                let jsonData = try Data(contentsOf: path)
                let data = try JSONDecoder().decode([Contact].self, from: jsonData)
                parseData(data)
            }
        } catch {
            print("Error decoding contacts: \(error)")
        }
    }
    
    @discardableResult func createContact() -> String {
        let name = ["Ani", "Yavor", "Asya", "Aleks", "Eva", "Albena", "Katya", "Bobi", "Stefani", "Kalina", "Vaya", "Viktor", "Vanesa", "Ceco", "Dafi", "Deni", "Angel", "Albena", "Bilqn", "Dori"].randomElement()!
        let firstLetter = name.first!

        if existingSections.contains(firstLetter) {
            var idxSection = 0
            for i in 0 ..< contacts.count {
                if contacts[i].first!.name.first! == firstLetter {
                    idxSection = i
                    break
                }
            }
                    
            contacts[idxSection].append(Contact(name: name))
            contacts[idxSection].sort { $0.name < $1.name }
        } else {
            existingSections.insert(firstLetter)
            contacts.append([Contact(name: name)])
            if contacts.count > 2 {
                contacts.sort { $0.first!.name < $1.first!.name }
            }
        }
        return name
    }
    
    func rowsInSection(_ section: Int) -> Int {
        return contacts[section].count
    }
    
    func titleSection(_ section: Int) -> String? {
        return contacts[section].count != 0 ? String(contacts[section][0].name.first!) : nil
    }
}
