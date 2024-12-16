//
//  MyLittlePonyApp.swift
//  MyLittlePony
//
//  Created by Berat Demir on 1.12.2024.
//

import SwiftUI

@main
struct MyLittlePonyApp: App {

    @StateObject var sessionmanager: SessionManager = .init()

    var body: some Scene {
        WindowGroup {
            EntryPointView()
                .environmentObject(sessionmanager)
        }
    }
}
