//
//  Card.swift
//  Cards
//
//  Created by Admin on 06.01.2022.
//

import Foundation

enum CardType: CaseIterable {
    case circle
    case cross
    case cquare
    case fill
}

enum CardColor: CaseIterable {
    case red
    case green
    case black
    case gray
    case brown
    case yelow
    case purple
    case orange
}

typealias Card = (type: CardType, color: CardColor)
