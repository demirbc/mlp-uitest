//
//  SettingsView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 10.12.2024.
//

import SwiftUI

struct SettingsView: View, Routeable {

    @EnvironmentObject var presentationRouter: PresentationRouter<SettingsRouter>
    @EnvironmentObject var navigationRouter: NavigationRouter
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.dismiss) var dismiss

    let registerHandler: () -> Void

    var body: some View {
        List {

            Group {
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.titlePink)
                    .padding(.top, 40)
                Text("Available Accounts")
                    .font(.headline)
                    .foregroundColor(Color.buttonPurple)
                if !sessionManager.accountList.isEmpty {
                    ForEach(Array(sessionManager.accountList), id: \.key) { account in
                        AccountView(account: account.key)
                    }
                } else {
                    NoAccountView()
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .listRowBackground(Color.clear)
        .safeAreaInset(edge: .bottom) {
            AddAccountButton {
                pop()
                registerHandler()
            }
        }
        .clipped()
        .background(MLPBackgroundView())
        .toolbar {
            Toolbar {
                dismiss()
            }
        }
    }
}

private struct AddAccountButton: View {

    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text("Add Account")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.buttonPurple)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    EntryPointView()
        .environmentObject(SessionManager())
}

private struct AccountView: View {

    @EnvironmentObject private var sessionManager: SessionManager

    let account: String

    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 30))
                .foregroundColor(Color("ButtonBlue"))
            Text(account)
                .font(.body)
                .foregroundColor(.black)
            Spacer(minLength: .zero)

            Button {
                sessionManager.removeAccount(account)
            } label: {
                Image(systemName: "x")
                    .symbolVariant(.circle)
            }
        }
        .padding(.vertical, 5)
        .mlpExpand(axis: .horizontal, alignment: .leading)
    }
}

private struct NoAccountView: View {

    var body: some View {
        HStack {
            Text("No Account available")
                .font(.body)
                .foregroundColor(.black)
        }
        .padding(.vertical, 5)
        .mlpExpand(axis: .horizontal, alignment: .leading)
    }
}

private struct Toolbar: ToolbarContent {

    let dismiss: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
                    .padding()
            }
            .accessId(AccessibilityIdentifier.dismissButton)
        }
        ToolbarItem(placement: .principal) {
            Text("Login")
                .fontWeight(.bold)
                .foregroundColor(Color.titlePink)
                .accessId(AccessibilityIdentifier.RegistrationView.title)
        }
    }
}
