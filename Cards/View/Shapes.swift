//
//  Shapes.swift
//  Cards
//
//  Created by Admin on 06.01.2022.
//

import Foundation
import UIKit


//Описываем слой с нарисованной фигурой
protocol ShapeLayerProtocol: CAShapeLayer {
    init(size: CGSize, fillColor: CGColor)
}
extension ShapeLayerProtocol {
    init() {
        fatalError("init() не может быть использован для создания экземпляра")
    }
}

//MARK: Объекты, описывающие слои с фигурами, которые будут на лицевой стороне карточки
//Фигура "Круг в центре"
class CircleShape: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let radius = ([size.height, size.width].min() ?? 0) / 2
        
        let centerX = size.width / 2
        let centerY = size.height / 2
        
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: CGPoint(x: centerX, y: centerY),
                           radius: radius,
                           startAngle: 0,
                           endAngle: .pi * 2,
                           clockwise: true)
        
        circlePath.close()
        self.path = circlePath.cgPath
        self.fillColor = fillColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Фигура "Квадрат"
class SquareShape: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let edgeSize = [size.height, size.width].min() ?? 0
        
        let rectPath = UIBezierPath(rect: CGRect(
            x: 0, y: 0,
            width: edgeSize,
            height: edgeSize))
        rectPath.close()
        
        self.path = rectPath.cgPath
        self.fillColor = fillColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Фигура "Крест"
class CrossShape: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let crossPath = UIBezierPath()
        crossPath.move(to: CGPoint(x: 0, y: 0))
        crossPath.addLine(to: CGPoint(x: size.width, y: size.height))
        crossPath.move(to: CGPoint(x: 0, y: size.height))
        crossPath.addLine(to: CGPoint(x: size.width, y: 0))
        
        self.path = crossPath.cgPath
        self.strokeColor = fillColor
        self.lineWidth = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//Фигура "Прямоугольник"
class FillShape: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let fillRect = UIBezierPath(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        fillRect.close()
        
        self.path = fillRect.cgPath
        self.fillColor = fillColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: Объекты, описывающие слои с фигурами, которые будут на задней стороне карточки
//Задняя сторона, рандомные круги.
class BackSideCircle: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let circlePath = UIBezierPath()
        
        for _ in 1...15 {
            
            let randomX = Int.random(in: 0...Int(size.width))
            let randomY = Int.random(in: 0...Int(size.height))
            let center = CGPoint(x: randomX, y: randomY)
            let radius = Int.random(in: 5...15)
            
            circlePath.move(to: center)
            circlePath.addArc(withCenter: center, radius: CGFloat(radius), startAngle: 0, endAngle: .pi * 2, clockwise: true)
//            circlePath.close()
            
            self.path = circlePath.cgPath
            self.strokeColor = fillColor
            self.fillColor = fillColor
            self.lineWidth = 1
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Задняя сторона, рандомные линии.
class BackSideLine: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let linesPath = UIBezierPath()
        
        for _ in 1...15 {
            
            let randomXStart = Int.random(in: 0...Int(size.width))
            let randomYStart = Int.random(in: 0...Int(size.height))
            
            let randomXEnd = Int.random(in: 0...Int(size.width))
            let randomYEnd = Int.random(in: 0...Int(size.height))
            
            
            linesPath.move(to: CGPoint(x: randomXStart, y: randomYStart))
            linesPath.addLine(to: CGPoint(x: randomXEnd, y: randomYEnd))
            
            self.path = linesPath.cgPath
            self.lineWidth = 3
            self.strokeColor = fillColor
            self.lineCap = .round
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
