//
//  RegistrationView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//

extension AccessibilityIdentifier {

    enum RegistrationView: String, AccessId {
        case title
        case usernameField
        case passwordField
        case confirmationPasswordField
        case registerButton
        case usernameError
        case passwordError
        case confirmationPasswordError

        var id: String {
            "RegistrationView_" + rawValue
        }
    }
}
