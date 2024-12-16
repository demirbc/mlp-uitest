//
//  PresentationRouter.swift
//  MyLittlePony
//
//  Created by Berat Demir on 8.12.2024.
//


import SwiftUI

@MainActor
final class PresentationRouter<R: Router>: ObservableObject {

    @Published var presentedRoute: R.PresentRoute?

    func present(route: R.PresentRoute) {
        presentedRoute = route
    }

    func dismissPresented() {
        presentedRoute = nil
    }
}
