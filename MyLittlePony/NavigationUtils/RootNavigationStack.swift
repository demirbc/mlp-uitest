//
//  RootNavigationStack.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//

import SwiftUI

struct RootNavigationStack<Content: View>:View {

    @StateObject var navigationRouter: NavigationRouter = .init()
    @ViewBuilder var content: Content

    var body: some View {
        NavigationStack(path: $navigationRouter.path) {
            content.environmentObject(navigationRouter)
        }
    }
}
