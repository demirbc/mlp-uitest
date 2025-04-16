//
//  MLPListViewRouter.swift
//  MyLittlePony
//
//  Created by Berat Demir on 6.01.2025.
//

import SwiftUI

struct MLPListViewRouter: Router {

    typealias SegueRoute = EmptyRoute

    enum PresentRoute: PrimitiveRoute {

        case pony(name: String)
    }

    @StateObject private var presentationRouter = PresentationRouter<Self>()
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @EnvironmentObject private var sessionManager: SessionManager
}

// MARK: - ViewModifier

extension MLPListViewRouter: ViewModifier {

    func body(content: Content) -> some View {
        content
            .environmentObject(presentationRouter)
            .environmentObject(navigationRouter)
            .fullScreenCover(item: $presentationRouter.presentedRoute) { route in
                switch route {

                case .pony(let name):
                    RootNavigationStack {
                        Text(name)
                    }
                }
            }
    }

}

#Preview {
    EntryPointView()
        .environmentObject(SessionManager())

}
