//
//  MainMenuHelper.swift
//  MyLittlePony
//
//  Created by Berat Demir on 16.12.2024.
//

import XCTest

protocol MainMenuHelper {

    var app: XCUIApplication { get }
}

extension MainMenuHelper {

    func checkEssentials() {

        let settingsGorukuyorSeysi: Bool = app.buttons[
            AccessibilityIdentifier.NotLoggedInEntryView.settings.id
        ].exists
        XCTAssertTrue(settingsGorukuyorSeysi)
        let loginButonuGorukuyorSeysi: Bool = app.buttons[
            AccessibilityIdentifier.NotLoggedInEntryView.login.id
        ].exists
        XCTAssertTrue(loginButonuGorukuyorSeysi)
        let registerButtonuGorukuyorSeysi: Bool = app
            .buttons[AccessibilityIdentifier.NotLoggedInEntryView.register.id].exists
        XCTAssertTrue(registerButtonuGorukuyorSeysi)
    }

    func tapRegisterButton() {
        app.buttons[AccessibilityIdentifier.NotLoggedInEntryView.register.id].tap()
    }
}
