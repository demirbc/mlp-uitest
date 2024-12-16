//
//  NotLoggedInEntryRouter.swift
//  MyLittlePony
//
//  Created by Berat Demir on 7.12.2024.
//

import SwiftUI

struct NotLoggedInEntryRouter: Router {

    enum SegueRoute: PrimitiveRoute {

        case settings
    }

    enum PresentRoute: PrimitiveRoute {

        case login
        case register
    }

    @StateObject private var presentationRouter = PresentationRouter<Self>()
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @EnvironmentObject private var sessionManager: SessionManager
}

// MARK: - ViewModifier

extension NotLoggedInEntryRouter: ViewModifier {

    func body(content: Content) -> some View {
        content
            .environmentObject(presentationRouter)
            .environmentObject(navigationRouter)
            .navigationDestination(for: Self.SegueRoute.self) { route in
                switch route {
                case .settings:
                    SettingsView {
                        presentationRouter.present(route: .register)
                    }
                    .modifier(SettingsRouter())
                    .environmentObject(sessionManager)
                    .environmentObject(navigationRouter)
                }
            }
            .fullScreenCover(item: $presentationRouter.presentedRoute) { route in
                switch route {
                case .login:
                    RootNavigationStack {
                        LoginView {
                            presentationRouter.present(route: .register)
                        }
                        .modifier(LoginRouter())
                        .environmentObject(sessionManager)
                    }
                case .register:
                    RootNavigationStack {
                        RegistrationView()
                            .modifier(RegistrationRouter())
                            .environmentObject(sessionManager)
                    }
                }
            }
    }

}

#Preview {
    EntryPointView()
        .environmentObject(SessionManager())
}
