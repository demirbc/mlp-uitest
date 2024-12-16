//
//  OTPRouter.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//

import SwiftUI

struct OTPRouter: Router {

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
