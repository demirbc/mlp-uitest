//
//  NavigationRouter.swift
//  MyLittlePony
//
//  Created by Berat Demir on 1.12.2024.
//

import SwiftUI

@MainActor
final class NavigationRouter: ObservableObject {

    @Published var path: NavigationPath = .init()

    init() { }

    func push<R: PrimitiveRoute>(_ route: R) {
        path.append(route)
    }

    func push<H: Hashable>(_ route: H) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }
}
