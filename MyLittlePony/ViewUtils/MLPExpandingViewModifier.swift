//
//  MLPExpandingViewModifier.swift
//  MyLittlePony
//
//  Created by Berat Demir on 8.12.2024.
//

import SwiftUI

struct MLPExpandingViewModifier: ViewModifier {

    let axis: Axis.Set
    let alignment: Alignment

    func body(content: Content) -> some View {
        ZStack(alignment: alignment) {
            if axis.contains(.horizontal) {
                Color.clear.fixedSize(horizontal: false, vertical: true)
            }
            if axis.contains(.vertical) {
                Color.clear.fixedSize(horizontal: true, vertical: false)
            }

            content
        }
    }
}

// MARK: - View Extension

extension View {

    func mlpExpand(axis: Axis.Set, alignment: Alignment = .center) -> some View {
        modifier(MLPExpandingViewModifier(axis: axis, alignment: alignment))
    }
}
