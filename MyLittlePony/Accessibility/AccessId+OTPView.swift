//
//  OTPView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//


extension AccessibilityIdentifier {

    enum OTPView: String, AccessId {
        case title
        case otpField
        case otpError
        case confirmationPasswordField
        case submitButton
        case popUpContinueButton

        var id: String {
            "OTPView_" + rawValue
        }
    }
}
