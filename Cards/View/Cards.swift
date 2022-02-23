//
//  Cards.swift
//  Cards
//
//  Created by Admin on 06.01.2022.
//

import Foundation
import UIKit

//Описываем карточку
protocol FlippableView: UIView {
    var isFlipped: Bool {get set}
    var flipCompletionHandler: ((FlippableView) -> Void)? {get set}
    func flip()
}

//Класс, описывающий карточку
class CardView<ShapeType: ShapeLayerProtocol>: UIView, FlippableView {
    
    var isFlipped: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    //Выводим перевернутую карточку наверх иерархии представлений
    var flipCompletionHandler: ((FlippableView) -> Void)? = { card in
        card.superview?.bringSubviewToFront(card)
    }
    //Анимируем переворот карточки
    func flip() {
        let fromView = isFlipped ? backSideView : frontSideView
        let toView = isFlipped ? frontSideView : backSideView
        
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionFlipFromTop], completion: {_ in
            self.flipCompletionHandler?(self)
        })
        isFlipped.toggle()
    }
    
    var cornerRadius: CGFloat = 20
    var color: UIColor!
    
    //Рисуем границы
    private func setupBorders() {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
        
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.color = color
        setupBorders()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Обновляем представление
    override func draw(_ rect: CGRect) {
        
        backSideView.removeFromSuperview()
        frontSideView.removeFromSuperview()
        
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
    }
    
    private var achorPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var startTouchPoint: CGPoint!

    //Добавляем функциональность касания
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        achorPoint.x = touches.first!.location(in: window).x - frame.minX
        achorPoint.y = touches.first!.location(in: window).y - frame.minY
        startTouchPoint = frame.origin
    }
    //Добавляем функциональность перемещения
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.frame.origin.x = touches.first!.location(in: window).x - achorPoint.x
        self.frame.origin.y = touches.first!.location(in: window).y - achorPoint.y
    }
    //События когда касание прекращается. Если карточку переместили, то ее не нужно переворачивать.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.frame.origin == startTouchPoint {
            flip() }
//        UIView.animate(withDuration: 1) {
////            self.frame.origin = self.startTouchPoint
//            if self.transform.isIdentity {
//                self.transform = CGAffineTransform(rotationAngle: .pi)
//            } else {
//                self.transform = .identity
//            }
//        }
    }
    
    
    //Внутренние границы карточки
    let margin = 10
    //Свойства, хранящие ссылки на представления лицевого и задней стороны
    lazy var frontSideView: UIView = self.getFrontSideView()
    lazy var backSideView: UIView = self.getBackSideView()
    
    //Метод, возвращающий лицевое представление
    func getFrontSideView() -> UIView {
        //Делаем слой, чтобы карточки не просвечивали
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.layer.masksToBounds = true
        
        let frontSideView = UIView(frame: CGRect(x: margin, y: margin, width: Int(view.bounds.width) - margin * 2, height: Int(view.bounds.height) - margin * 2))
        
        frontSideView.layer.addSublayer(ShapeType(size: frontSideView.frame.size, fillColor: color.cgColor))
        view.addSubview(frontSideView)
        return view
    }
    
    //Метод, возвращающий представление задней стороны
    func getBackSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.layer.masksToBounds = true
        
        switch ["circle", "lines"].randomElement() {
        case "circle":
            view.layer.addSublayer(BackSideCircle(size: view.bounds.size, fillColor: UIColor.black.cgColor))
        case "lines":
            view.layer.addSublayer(BackSideLine(size: view.bounds.size, fillColor: UIColor.black.cgColor))
        default:
            break
        }
    return view
    }
}
