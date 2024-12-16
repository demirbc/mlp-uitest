//
//  SettingsRouter.swift
//  MyLittlePony
//
//  Created by Berat Demir on 10.12.2024.
//


import SwiftUI

struct SettingsRouter: Router {

    typealias SegueRoute = EmptyRoute
    typealias PresentRoute = EmptyRoute

    @StateObject private var presentationRouter = PresentationRouter<Self>()
    @EnvironmentObject private var navigationRouter: NavigationRouter

    func body(content: Content) -> some View {
        content
            .environmentObject(presentationRouter)
            .environmentObject(navigationRouter)
    }
}
