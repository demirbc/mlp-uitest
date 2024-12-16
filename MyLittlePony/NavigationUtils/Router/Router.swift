//
//  Router.swift
//  MyLittlePony
//
//  Created by Berat Demir on 7.12.2024.
//

import SwiftUI

protocol Router: ViewModifier {

    associatedtype SegueRoute: PrimitiveRoute

    associatedtype PresentRoute: PrimitiveRoute
}
