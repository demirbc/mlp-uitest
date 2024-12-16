//
//  SessionManager.swift
//  MyLittlePony
//
//  Created by Berat Demir on 1.12.2024.
//

import Foundation

final class SessionManager: ObservableObject {

    enum SessionError: Error, LocalizedError {

        case cancelled
        case invalidPassword
        case invalidUsername
        case invalidAccount
        case noSuchAccount

        var errorDescription: String? {
            switch self {
            case .cancelled:
                "The operation was cancelled."
            case .invalidPassword:
                "The password provided is invalid."
            case .invalidUsername:
                "The username provided is invalid."
            case .invalidAccount:
                "The account details are invalid."
            case .noSuchAccount:
                "No account was found with the provided details."
            }
        }
    }

    @Published private(set) var accountList: [String: String] = ["hello1": "ka123123"]

    @Published private(set) var loggedInAccount: String?

    var isLoggedIn: Bool { loggedInAccount != nil }


    func login(name: String, password: String) throws(SessionError) {
        guard let accountPassword = accountList[name] else {
            throw .noSuchAccount
        }
        guard accountPassword == password else {
            throw .invalidPassword
        }
        loggedInAccount = name
    }

    func removeAccount(_ name: String) {
        accountList[name] = nil
    }

    func logout() {
        loggedInAccount = nil
    }

    func deleteAccount() throws(SessionError) {
        guard let loggedInAccount else {
            throw .invalidAccount
        }

        if accountList[loggedInAccount] == nil {
            throw .noSuchAccount
        }
        accountList[loggedInAccount] = nil
        self.loggedInAccount = nil
    }

    func register(name: String, password: String) {
        accountList[name] = password
    }
}
