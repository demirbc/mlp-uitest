//
//  OTPViewModel.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//

import Foundation

@MainActor
final class OTPViewModel: ObservableObject {

    @Published private(set) var startDate: Date = .init()
    @Published private(set) var endDate: Date = .init(timeIntervalSinceNow: 5 * 60)
    @Published private(set) var result: OTPState = .running

    let username: String
    let password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    var countDownRange: ClosedRange<Date>? {
        guard startDate < endDate else { return nil }
        return .init(uncheckedBounds: (lower: startDate, upper: endDate))
    }

    func resendOtp() {
        startDate = .now
        endDate = .init(timeIntervalSinceNow: 5 * 60)
        result = .running
    }

    func submitOTP(_ otp: String) {
        guard endDate > .now else {
            result = .timeout
            return
        }

        guard otp == "111111" else {
            result = .failure
            return
        }
        result = .success
    }
}
