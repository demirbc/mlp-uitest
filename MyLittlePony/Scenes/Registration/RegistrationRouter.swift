//
//  RegistrationRouter.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//

import SwiftUI

struct RegistrationRouter: Router {

    typealias PresentRoute = EmptyRoute

    enum SegueRoute: PrimitiveRoute {
        case otp(username: String, password: String)
    }

    @StateObject private var presentationRouter = PresentationRouter<Self>()
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @EnvironmentObject private var sessionManager: SessionManager
    @Environment(\.dismiss) private var dismiss

    func body(content: Content) -> some View {
        content
            .environmentObject(navigationRouter)
            .environmentObject(presentationRouter)
            .navigationDestination(for: Self.SegueRoute.self) { route in
                switch route {
                case .otp(let username, let password):
                    OTPView(username: username, password: password) {
                        dismiss()
                    }
                    .modifier(OTPRouter())
                    .environmentObject(sessionManager)
                    .environmentObject(navigationRouter)
                }
            }
    }
}
#Preview {
    EntryPointView()
        .environmentObject(SessionManager())
}
