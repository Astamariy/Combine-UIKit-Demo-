//
//  AnyUnit.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 15.04.2022.
//

import Foundation

enum AnyUnit<I, O>: UnitType {
    typealias Input = I
    typealias Output = O
}
