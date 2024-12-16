//
//  View+Extensions.swift
//  MyLittlePony
//
//  Created by Berat Demir on 1.12.2024.
//

import SwiftUI

extension View {

    func router<R: Router>(_ router: R) -> some View {
        modifier(router)
    }
}
