//
//  ListView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 13.01.2025.
//


extension AccessibilityIdentifier {

    enum ListView: String, AccessId {

        case title
        case carousel
        case logout
        case header
        case info

        var id: String {
            "ListView_" + rawValue
        }
    }
}
