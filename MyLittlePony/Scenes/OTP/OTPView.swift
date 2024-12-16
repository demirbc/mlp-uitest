//
//  OTPView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//

import SwiftUI

struct OTPView: View, Routeable {

    @EnvironmentObject var presentationRouter: PresentationRouter<OTPRouter>
    @EnvironmentObject var navigationRouter: NavigationRouter
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.dismiss) private var dismiss

    @State private var otp: String = ""
    @State private var showAlert: Bool = false

    @StateObject private var viewModel: OTPViewModel
    let onSuccess: () -> Void

    init(username: String, password: String, onSuccess: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: .init(username: username, password: password))
        self.onSuccess = onSuccess
    }

    var body: some View {
        VStack(spacing: 20) {

            Spacer()

            Text("Enter OTP")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.titlePink)
                .padding(.top, 40)
                .accessId(AccessibilityIdentifier.OTPView.title)

            HStack {
                ForEach(0..<5, id: \.self) { _ in
                    Image(.pinkiePie)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .frame(height: 40)

            OTPTextField(otp: $otp)
                .onChange(of: viewModel.result) { value in
                    switch value {
                    case .success:
                        showAlert = true
                    default:
                        showAlert = false
                    }
                }
                .alert("OTP is successfully verified!", isPresented: $showAlert) {
                    Button {
                        sessionManager.register(name: viewModel.username, password: viewModel.password)
                        onSuccess()
                    } label: {
                        Text("Continue")
                    }
                    .accessId(AccessibilityIdentifier.OTPView.popUpContinueButton)
                }

            Group {
                switch viewModel.result {
                case .failure:
                    Text("OTP failure, please retry")
                case .timeout:
                    Text("OTP timeout, please retry")
                default:
                    EmptyView()
                }
            }
            .foregroundColor(.red)
            .font(.footnote)


            MLPFriendsBanner()
                .frame(height: 40)

            if let countDownRange = viewModel.countDownRange {
                VStack {
                    HStack {
                        Text("Remaining Time:")
                        Spacer()
                        Text(timerInterval: countDownRange)
                    }
                    ProgressView(timerInterval: countDownRange, countsDown: true) {
                        EmptyView()
                    } currentValueLabel: {
                        EmptyView()
                    }
                    .scaleEffect(x: 1, y: 2, anchor: .center)
                    .tint(.lavender)
                }
            }

            Button {
                viewModel.submitOTP(otp)
            } label: {
                Text("Verify OTP")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .mlpExpand(axis: .horizontal)
                    .background(Color("ButtonBlue"))
                    .cornerRadius(12)
            }
            .padding(.bottom, 20)
            .opacity(otp.count < 6 ? 0.5 : 1)
            .disabled(otp.count < 6)

            Spacer()
        }
        .padding(.horizontal, 30)
        .background(MLPBackgroundView())
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    pop()
                } label: {
                    Image(systemName: "arrow.left")
                        .renderingMode(.template)
                        .foregroundColor(.black)
                }
                .accessId(AccessibilityIdentifier.backButton)
            }
            ToolbarItem(placement: .principal) {
                Text("OTP")
                    .fontWeight(.bold)
                    .foregroundColor(Color.titlePink)
                    .accessId(AccessibilityIdentifier.OTPView.title)
            }
        }
    }
}

private struct OTPTextField: View {

    @Binding var otp: String

    var body: some View {
        TextField("Enter 6-digit OTP", text: $otp)
            .keyboardType(.numberPad)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .autocapitalization(.none)
            .textInputAutocapitalization(.never)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .onChange(of: otp) { newValue in
                otp = String(newValue.prefix(6)).filter { $0.isNumber }
            }
            .accessId(AccessibilityIdentifier.OTPView.otpField)

    }
}

private struct MLPFriendsBanner: View {

    var body: some View {
        HStack {
            ForEach(0..<5, id: \.self) { _ in
                Image(.pinkiePie)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#Preview {
    EntryPointView()
        .environmentObject(SessionManager())
}
