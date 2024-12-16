//
//  PrimitiveRoute.swift
//  MyLittlePony
//
//  Created by Berat Demir on 7.12.2024.
//

protocol PrimitiveRoute: Sendable, Codable, Hashable, Identifiable {}

extension PrimitiveRoute {

    var id: Int { self.hashValue }
}
