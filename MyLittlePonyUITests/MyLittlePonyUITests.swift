//
//  MyLittlePonyUITests.swift
//  MyLittlePonyUITests
//
//  Created by Berat Demir on 1.12.2024.
//

import XCTest

final class MyLittlePonyUITests: XCTestCase, KeyboardImplement, MainMenuHelper {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testRegisterSeysi() {
        checkEssentials()
        tapRegisterButton()

        let dismissGorukuyorSeysi: Bool = app.buttons["dismissButton"].exists
        XCTAssertTrue(dismissGorukuyorSeysi)
        
        let regTitleGorukuyorSeysi: Bool = app.staticTexts["RegistrationViewtitle"].exists
        XCTAssertTrue(regTitleGorukuyorSeysi)
        
        let regNameFieldGorukuyorSeysi: Bool = app.textFields["RegistrationViewusernameField"]
            .exists
        XCTAssertTrue(regNameFieldGorukuyorSeysi)
        
        let regPasswordFieldGorukuyorSeysi: Bool = app.secureTextFields[
            "RegistrationViewpasswordField"
        ].exists
        XCTAssertTrue(regPasswordFieldGorukuyorSeysi)
        let regPassConfirmGorukuyorSeysi: Bool = app.secureTextFields[
            "RegistrationViewconfirmationPasswordField"
        ].exists
        XCTAssertTrue(regPassConfirmGorukuyorSeysi)
        let registerButtonGorukuyorSeysi: Bool = app.buttons["registerButton"].exists
        XCTAssertTrue(registerButtonGorukuyorSeysi)
        let nameEnabledSeysi: Bool = app.textFields["RegistrationViewusernameField"].isEnabled
        XCTAssertTrue(nameEnabledSeysi)
        let passwordEnabledSeysi: Bool = app.secureTextFields[
            "RegistrationViewconfirmationPasswordField"
        ].isEnabled
        XCTAssertTrue(passwordEnabledSeysi)
        let confirmEnabledSeysi: Bool = app.secureTextFields[
            "RegistrationViewconfirmationPasswordField"
        ].isEnabled
        XCTAssertTrue(confirmEnabledSeysi)
        let registerEnabledSeysi: Bool = app.buttons["registerButton"].isEnabled
        XCTAssertFalse(registerEnabledSeysi)
        app.textFields["RegistrationViewusernameField"].tap()
        sleep(5)
        writeKeyboard(value: "a")
        let isimErrorSeysi: Bool = app.staticTexts["RegistrationViewusernameError"].exists
        XCTAssertTrue(isimErrorSeysi)
        let isimErrorValueSeysi: String = app.staticTexts["RegistrationViewusernameError"].label
        XCTAssertEqual(isimErrorValueSeysi, "Username has to be longer than 6")
        app.textFields["RegistrationViewusernameField"].tap()
        app.keys["delete"].tap()
        writeKeyboard(value: "naberberat")
        //  XCTAssertTrue(isimErrorSeysi)
        let isimErrorSeysiIki: Bool = app.staticTexts["RegistrationViewusernameError"].exists
        XCTAssertFalse(isimErrorSeysiIki)
        app.secureTextFields["RegistrationViewpasswordField"].tap()
        sleep(5)
        app.keys["more"].tap()
        writeKeyboard(value: "123")
        let passwordKisaSeysi: Bool = app.staticTexts["RegistrationViewpasswordError"].exists
        XCTAssertTrue(passwordKisaSeysi)
        let passwordKisaValueSeysi: String = app.staticTexts["RegistrationViewpasswordError"].label
        XCTAssertEqual(passwordKisaValueSeysi, "Password must be at least 8 characters long.")
        app.secureTextFields["RegistrationViewpasswordField"].tap()
        sleep(5)
        app.keys["more"].tap()
        writeKeyboard(value: "123123123")
        let alphanumSeysi: Bool = app.staticTexts["RegistrationViewpasswordError"].exists
        XCTAssertTrue(alphanumSeysi)
        let alphanumValueSeysi: String = app.staticTexts["RegistrationViewpasswordError"].label
        XCTAssertEqual(alphanumValueSeysi, "Password must be alphanumeric.")
        app.secureTextFields["RegistrationViewpasswordField"].tap()
        app.secureTextFields["RegistrationViewpasswordField"].typeText("123123123a")
        let passwordcorrectSeysi: Bool = app.staticTexts["RegistrationViewpasswordError"].exists
        XCTAssertFalse(passwordcorrectSeysi)
        app.secureTextFields["RegistrationViewconfirmationPasswordField"].tap()
        app.secureTextFields["RegistrationViewconfirmationPasswordField"].typeText("123123123b")
        let confirmationErrorSeysi: Bool = app.staticTexts[
            "RegistrationViewconfirmationPasswordError"
        ].exists
        XCTAssertTrue(confirmationErrorSeysi)
        let confirmErrorValueSeysi: String = app.staticTexts[
            "RegistrationViewconfirmationPasswordError"
        ].label
        XCTAssertEqual(confirmErrorValueSeysi, "Confirmtation Password does not match")
        app.secureTextFields["RegistrationViewpasswordField"].tap()
        app.secureTextFields["RegistrationViewconfirmationPasswordField"].tap()
        app.secureTextFields["RegistrationViewconfirmationPasswordField"].typeText("123123123a")
        let confirmedSeysi: Bool = app.staticTexts["RegistrationViewconfirmationPasswordError"]
            .exists
        XCTAssertFalse(confirmedSeysi)
        let herSeyOkeySeysi: Bool = app.buttons["registerButton"].isEnabled
        XCTAssertTrue(herSeyOkeySeysi)
        app.buttons["registerButton"].tap()
        let otpFieldSeysi: Bool = app.textFields["OTPViewotpField"].exists
        XCTAssertTrue(otpFieldSeysi)
        let otpFieldEnabledSeysi: Bool = app.textFields["OTPViewotpField"].isEnabled
        XCTAssertTrue(otpFieldEnabledSeysi)
        let otpButtonSeysi: Bool = app.buttons["verifyOtpButton"].exists
        XCTAssertTrue(otpButtonSeysi)
        let otpButtonEnabledSeysi: Bool = app.buttons["verifyOtpButton"].isEnabled
        XCTAssertFalse(otpButtonEnabledSeysi)
        app.textFields["OTPViewotpField"].tap()
        app.textFields["OTPViewotpField"].typeText("123456")
        let otpButtonEnabledSeysiIki: Bool = app.buttons["verifyOtpButton"].isEnabled
        XCTAssertTrue(otpButtonEnabledSeysiIki)
        app.buttons["verifyOtpButton"].tap()
        let otpFailureSeysi: Bool = app.staticTexts["otpFailure"].exists
        XCTAssertTrue(otpFailureSeysi)
        let otpFailureValueSeysi: String = app.staticTexts["otpFailure"].label
        XCTAssertEqual(otpFailureValueSeysi, "OTP failure, please retry")
        app.textFields["OTPViewotpField"].tap(withNumberOfTaps: 3, numberOfTouches: 1)
        app.textFields["OTPViewotpField"].typeText("111111")
        app.buttons["verifyOtpButton"].tap()
        let successSeysi: Bool = app.buttons["successButton"].exists
        let successEnabledSeysi: Bool = app.buttons["successButton"].isEnabled
        XCTAssertTrue(successEnabledSeysi)
        XCTAssertTrue(successSeysi)
        app.buttons["successButton"].tap()
        
        
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                app.launch()
            }
        }
    }
}

