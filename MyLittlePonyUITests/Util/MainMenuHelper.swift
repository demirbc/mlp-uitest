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
        let settingsGorukuyorSeysi: Bool = app.buttons["NotLoggedInEntryViewsettings"].exists
        XCTAssertTrue(settingsGorukuyorSeysi)
        let loginButonuGorukuyorSeysi: Bool = app.buttons["NotLoggedInEntryViewlogin"].exists
        XCTAssertTrue(loginButonuGorukuyorSeysi)
        let registerButtonuGorukuyorSeysi: Bool = app.buttons["NotLoggedInEntryViewregister"].exists
        XCTAssertTrue(registerButtonuGorukuyorSeysi)
    }
    
    func tapRegisterButton() {
        app.buttons["NotLoggedInEntryViewregister"].tap()
    }
}
