//
//  RegistrationView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//

extension AccessibilityIdentifier {

    enum LoginView: String, AccessId {
        case title
        case usernameField
        case passwordField
        case registerButton
        case usernameError
        case passwordFieldShowButton
        case loginButton

        var id: String {
            "Loginview_" + rawValue
        }
    }
}
