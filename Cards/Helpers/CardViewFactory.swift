//
//  CardViewFactory.swift
//  Cards
//
//  Created by Admin on 06.01.2022.
//

import Foundation
import UIKit

class CardViewFactory {
    func get(_ shape: CardType, withSize size: CGSize, andColor color: CardColor) -> UIView {
        
        let frame = CGRect(origin: .zero, size: size)
        let viewColor = getViewColorBy(modelColor: color)
        
        switch shape {
        case .circle:
            return CardView<CircleShape>(frame: frame, color: viewColor)
        case .cross:
            return CardView<CrossShape>(frame: frame, color: viewColor)
        case .cquare:
            return CardView<SquareShape>(frame: frame, color: viewColor)
        case .fill:
            return CardView<FillShape>(frame: frame, color: viewColor)
        }
    }
        
        private func getViewColorBy(modelColor: CardColor) -> UIColor {
            switch modelColor {
            case .black:
                return .black
            case .gray:
                return .gray
            case .orange:
                return .orange
            case .purple:
                return .purple
            case .brown:
                return .brown
            case .green:
                return .green
            case .red:
                return .red
            case .yelow:
                return .yellow
            }
        }
        
    
}
