//
//  Constants.swift
//  OrienPay
//
//  Created by Buzurg Rakhımzoda on 24.06.2023.
//

import Foundation
import SwiftUI

extension Bundle{
    func decode<T: Codable>(_ file: String) -> T {
        // 1. Locate the JSON file
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Failed to locate \(file) in bundle")
        }
        // 2. Create a property for the data
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Failed to load \(file) from bundle")
        }
        // 3. Create a decoder
        let decoder = JSONDecoder()
        // 4. Create a property for the decoded data
        guard let decodedData = try? decoder.decode(T.self, from: data) else{
            fatalError("Failed to decode \(file) from bundle")
        }
        // 5. Return to ready-to-use data
        return decodedData
    }
}


let logoBlue: Color = Color("BlueLogo")
let logoYellow: Color = Color("YellowLogo")

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

let buttonsHome: [buttonsDataHome] = Bundle.main.decode("buttonsDataHome.json")
let buttonsSettings: [ButtonsDataSettings] = Bundle.main.decode("buttonsDataSettings.json")
