//
//  AccessId.swift
//  MyLittlePony
//
//  Created by Berat Demir on 9.12.2024.
//

protocol AccessId: RawRepresentable where Self.RawValue == String {

    var id: String { get }
}
