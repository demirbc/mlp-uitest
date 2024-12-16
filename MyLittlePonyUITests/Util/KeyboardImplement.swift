//
//  KeyboardImplement.swift
//  MyLittlePony
//
//  Created by Berat Demir on 16.12.2024.
//

import XCTest

protocol KeyboardImplement {
    
    var app: XCUIApplication { get }
}

extension KeyboardImplement {
    
    func writeKeyboard(value: String) {
        let charArray: [String.Element] = Array(value)
        for char in charArray {
            let key = app.keyboards.keys["\(char)"]
            key.tap()
        }
        app.keyboards.buttons["Return"].tap()
    }
}
