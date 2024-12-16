//
//  LoginView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 10.12.2024.
//

import SwiftUI

struct LoginView: View, Routeable {

    @EnvironmentObject var presentationRouter: PresentationRouter<LoginRouter>
    @EnvironmentObject var navigationRouter: NavigationRouter

    @State private var username: String = ""
    @State private var password: String = ""

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var sessionManager: SessionManager

    let registerHandler: () -> Void

    var body: some View {
        VStack {
            Banner()

            Spacer()

            InputField(username: $username, password: $password)


            LoginButton(
                sessionManager: sessionManager,
                username: username,
                password: password
            )

            RegisterButton {
                dismiss()
                registerHandler()
            }

            Spacer()
        }
        .background(MLPBackgroundView())
        .toolbar {
            Toolbar {
                dismiss()
            }
        }
    }
}

private struct Banner: View {

    var body: some View {
        HStack {
            Image(.pinkiePie)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.titlePink)
                .padding(.top, 40)
                .accessId(AccessibilityIdentifier.LoginView.title)
            Image(.pinkiePie)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
    }
}

private struct InputField: View {

    @State private var showPassword = false

    @Binding var username: String
    @Binding var password: String

    var body: some View {
        VStack(spacing: 20) {
            // Username Field
            TextField("Username", text: $username)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                .autocapitalization(.none)
                .textInputAutocapitalization(.never)
                .foregroundColor(.black)
                .padding(.horizontal, 30)
                .accessId(AccessibilityIdentifier.LoginView.usernameField)

            // Password Field
            HStack {
                if showPassword {
                    TextField("Password", text: $password)
                } else {
                    SecureField("Password", text: $password)
                }
                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(Color.gray)
                }
                .accessId(AccessibilityIdentifier.LoginView.passwordFieldShowButton)
                .accessibilityValue(showPassword ? "show" : "hide")
            }
            .accessId(AccessibilityIdentifier.LoginView.passwordField)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
            .autocapitalization(.none)
            .textInputAutocapitalization(.never)
            .foregroundColor(.black)
            .padding(.horizontal, 30)
        }
        .padding(.bottom, 10)
    }
}

private struct LoginButton: View {

    let sessionManager: SessionManager

    @State private var loginError: String?
    @State private var showError = false
    let username: String
    let password: String

    var body: some View {
        Button {
            do {
                try sessionManager.login(name: username, password: password)
            } catch {
                loginError = error.localizedDescription
                showError = loginError != nil
            }
        } label: {
            Text("Login")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .mlpExpand(axis: .horizontal)
                .background(Color.buttonBlue)
                .cornerRadius(12)
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 10)
        .accessId(AccessibilityIdentifier.LoginView.loginButton)
        .alert(
            "Error occured when logging in",
            isPresented: $showError
        ) {
            Text("Try again")
        } message: {
            if let loginError {
                Text(loginError)
            }
        }
    }
}

struct RegisterButton: View {

    let registerHandler: () -> Void

    var body: some View {
        Button {
            registerHandler()
        } label: {
            Text("Don't have an account? Register")
                .font(.subheadline)
                .foregroundColor(Color.buttonPurple)
        }
        .padding(.bottom, 20)
        .accessId(AccessibilityIdentifier.LoginView.registerButton)
    }
}

private struct Toolbar: ToolbarContent {

    let dismiss: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "x")
                    .symbolVariant(.circle)
                    .foregroundColor(.black)
                    .padding()
            }
            .accessId(AccessibilityIdentifier.dismissButton)
        }
        ToolbarItem(placement: .principal) {
            Text("Login")
                .fontWeight(.bold)
                .foregroundColor(Color.titlePink)
                .accessId(AccessibilityIdentifier.LoginView.title)
        }
    }
}

#Preview {
    EntryPointView()
        .environmentObject(SessionManager())
}
