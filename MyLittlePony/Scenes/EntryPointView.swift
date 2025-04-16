//
//  EntryPointView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//

import SwiftUI
import AppIntents
struct EntryPointView: View {

    @EnvironmentObject var sessionmanager: SessionManager
    @StateObject var notLoggedInEntryViewRouter = NavigationRouter()

    var body: some View {
        if sessionmanager.isLoggedIn {
            RootNavigationStack {
                MLPListView()
            }
        } else {
            RootNavigationStack(navigationRouter: notLoggedInEntryViewRouter) {
                NotLoggedInEntryView()
                    .modifier(NotLoggedInEntryRouter())
                    .environmentObject(sessionmanager)
            }
        }
    }
}

#Preview {
    EntryPointView()
        .environmentObject(SessionManager())

}
