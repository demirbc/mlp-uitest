//
//  RegistrationView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 8.12.2024.
//

import SwiftUI

struct RegistrationView: View , Routeable {

    @EnvironmentObject var presentationRouter: PresentationRouter<RegistrationRouter>
    @EnvironmentObject var navigationRouter: NavigationRouter
    @Environment(\.dismiss) var dismiss

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var hasError = false

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Image(.pinkiePie)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.titlePink)
                    .accessId(AccessibilityIdentifier.RegistrationView.title)
                Image(.pinkiePie)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
            }
            .frame(height: 100)
            Spacer()

            VStack(spacing: 20) {
                UsernameTextField(username: $username)
                PasswordTextField(password: $password)
            }
            .padding(.bottom, 20)

            // Register Button
            Button {
                push(.otp(username: username, password: password))
            } label: {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .mlpExpand(axis: .horizontal)
                    .background(Color.buttonPurple)
                    .cornerRadius(12)
                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
            }
            .accessId(AccessibilityIdentifier.RegistrationView.registerButton)
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
            .opacity(isButtonDisabled ? 0.5 : 1)
            .disabled(isButtonDisabled)

            Spacer()
        }
        .onPreferenceChange(ErrorValidatorPreferenceKey.self) { error in
            hasError = error != nil
        }
        .background(MLPBackgroundView())
        .toolbar {
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
                Text("Register")
                    .fontWeight(.bold)
                    .foregroundColor(Color.titlePink)
                    .accessId(AccessibilityIdentifier.RegistrationView.title)
            }
        }
    }

    var isButtonDisabled: Bool {
        hasError || username.isEmpty || password.isEmpty
    }
}

private struct UsernameTextField: View {

    @State private var error: String?
    @Binding var username: String

    var body: some View {
        VStack(alignment: .trailing, spacing: .zero) {
            TextField("Username", text: $username)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .autocapitalization(.none)
                .textInputAutocapitalization(.never)
                .foregroundColor(.black)
                .preference(
                    key: ErrorValidatorPreferenceKey.self,
                    value: error
                )
                .onChange(of: username) { value in
                    error =
                        if value.count < 6 {
                            "Username has to be longer than 6"
                        } else if value.count > 10 {
                            "Username has to be shorter than 10"
                        } else {
                            nil
                        }
                }
                .accessId(AccessibilityIdentifier.RegistrationView.usernameField)
            if let error {
                Text(error)
                    .foregroundColor(.red)
                    .accessId(AccessibilityIdentifier.RegistrationView.usernameError)

            }
        }
        .mlpExpand(axis: .horizontal, alignment: .trailing)
        .padding(.horizontal, 30)
    }
}

private struct PasswordTextField: View {

    @Binding var password: String
    @State private var confirmPassword: String = ""
    @State private var passwordError: String?
    @State private var confirmPasswordError: String?

    var body: some View {
        VStack(spacing: 20) {

            Group {
                // Password Field
                VStack {
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .preference(
                            key: ErrorValidatorPreferenceKey.self,
                            value: confirmPassword.isEmpty ? "Confirmtation Password does not match" : passwordError
                        )
                        .onChange(of: password) { value in
                            passwordError = validatePassword(value)
                        }
                        .accessId(AccessibilityIdentifier.RegistrationView.passwordField)
                    if let passwordError {
                        Text(passwordError)
                            .foregroundColor(.red)
                            .accessId(AccessibilityIdentifier.RegistrationView.passwordError)
                    }
                }

                VStack {
                    // Confirm Password Field
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .preference(
                            key: ErrorValidatorPreferenceKey.self,
                            value: confirmPasswordError
                        )
                        .onChange(of: confirmPassword) { value in
                            let error = validatePassword(value)
                            confirmPasswordError =
                                if let error {
                                    error
                                } else if confirmPassword != password {
                                    "Confirmtation Password does not match"
                                } else {
                                    nil
                                }
                        }
                        .accessId(
                            AccessibilityIdentifier.RegistrationView.confirmationPasswordField
                        )

                    if let confirmPasswordError {
                        Text(confirmPasswordError)
                            .foregroundColor(.red)
                            .accessId(
                                AccessibilityIdentifier.RegistrationView.confirmationPasswordError
                            )
                    }
                }
            }

            .autocapitalization(.none)
            .textInputAutocapitalization(.never)
            .foregroundColor(.black)
            .padding(.horizontal, 30)
        }
    }
    private func validatePassword(_ password: String) -> String? {
        if password.count < 8 {
            "Password must be at least 8 characters long."
        } else if password.count > 24 {
            "Password must be no more than 24 characters long."
        } else if !(password.contains(where: \.isLetter) && password.contains(where: \.isNumber)) {
            "Password must be alphanumeric."
        } else {
            nil  // No error
        }
    }
}

#Preview {
    EntryPointView()
        .environmentObject(SessionManager())
}

enum ErrorValidatorPreferenceKey: PreferenceKey {

    static let defaultValue: String? = nil

    static func reduce(value: inout Value, nextValue: () -> Value) {
        if value != nil {
            return
        }
        value = nextValue()
    }
}
