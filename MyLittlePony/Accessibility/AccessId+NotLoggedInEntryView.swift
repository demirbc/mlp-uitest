//
//  NotLoggedInEntryView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//

extension AccessibilityIdentifier {

    enum NotLoggedInEntryView: String, AccessId {
        case title
        case login
        case register
        case settings
        var id: String {
            "NotLoggedInEntryView_" + rawValue
        }
    }
}
