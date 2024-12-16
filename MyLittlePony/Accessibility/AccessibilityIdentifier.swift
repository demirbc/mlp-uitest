//
//  AccessibilityIdentifier.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//

enum AccessibilityIdentifier: String, AccessId {

    case dismissButton
    case backButton

    var id: String {
        "General_" + rawValue
    }
}
