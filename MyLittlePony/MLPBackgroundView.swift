//
//  MLPBackgroundView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 8.12.2024.
//

import SwiftUI

struct MLPBackgroundView: View {
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.backgroundBlue,
                Color.backgroundPink,
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
        .contentShape(Rectangle())
        .onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }
    }
}
