// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - ButtonsDataSettings
struct ButtonsDataSettings: Codable, Hashable{
    let text: String
    let destination: Destination
}

// MARK: - Destination
struct Destination: Codable, Hashable{
    let desbuttons: [Desbutton]
    let destoggles: [Destoggle]
    let destext: String
}

// MARK: - Desbutton
struct Desbutton: Codable, Hashable {
    let text: String?
    let header: String?
}

// MARK: - Destoggle
struct Destoggle: Codable, Hashable{
    let text: String
    let toggle: Bool
    let header: String
}
