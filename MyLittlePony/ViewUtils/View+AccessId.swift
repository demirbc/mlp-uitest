//
//  AccessId.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//

import SwiftUI

extension View {

    func accessId<T: AccessId>(_ id: T) -> some View {
        accessibilityIdentifier(id.id)
    }
}
