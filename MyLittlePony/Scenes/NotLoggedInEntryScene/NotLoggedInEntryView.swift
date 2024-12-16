//
//  NotLoggedInEntryView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 7.12.2024.
//

import SwiftUI

struct NotLoggedInEntryView: View, Routeable {

    @EnvironmentObject var presentationRouter: PresentationRouter<NotLoggedInEntryRouter>
    @EnvironmentObject var navigationRouter: NavigationRouter

    var body: some View {

        VStack(spacing: 100) {
            VStack {
                Text("My Little Pony")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.titlePink)
                    .accessId(AccessibilityIdentifier.NotLoggedInEntryView.title)

                Image(.pinkiePie)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 100)
            }
            .padding(.top, 40)
            // Buttons
            VStack(spacing: 20) {
                Button {
                    present(.login)
                } label: {
                    Text("Login")
                        .mlpExpand(axis: .horizontal)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.buttonBlue)
                        .cornerRadius(12)
                }
                .accessId(AccessibilityIdentifier.NotLoggedInEntryView.login)
                Button {
                    present(.register)
                } label: {
                    Text("Register")
                        .mlpExpand(axis: .horizontal)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.buttonPurple)
                        .cornerRadius(12)
                }
                .accessId(AccessibilityIdentifier.NotLoggedInEntryView.register)
            }
            .padding(.horizontal, 30)

            Spacer()

        }
        .background(MLPBackgroundView())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    push(.settings)
                } label: {
                    Image(systemName: "gearshape")
                        .foregroundColor(.black)
                        .padding()
                }
                .accessId(AccessibilityIdentifier.NotLoggedInEntryView.settings)
            }
        }
    }
}

#Preview {
    EntryPointView()
        .environmentObject(SessionManager())
}
