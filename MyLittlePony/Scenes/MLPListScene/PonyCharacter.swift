//
//  PonyCharacter.swift
//  MyLittlePony
//
//  Created by Berat Demir on 13.01.2025.
//

import Foundation

struct PonyCharacter: Identifiable {
    let id = UUID()
    let name: String
    let description: String

    var accessId: String {
        name.replacingOccurrences(of: " ", with: "_")
    }
}
