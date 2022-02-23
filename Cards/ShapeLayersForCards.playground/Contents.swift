//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

protocol ShapeLayerProtocol: CAShapeLayer {
    init(size: CGSize, fillColor: CGColor)
}

extension ShapeLayerProtocol {
    init() {
        fatalError("init() не может быть использован для создания экземпляра")
    }
}

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

class CrossShape: CAShapeLayer, ShapeLayerProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let crossPath = UIBezierPath()
        crossPath.move(to: CGPoint(x: 0, y: 0))
        crossPath.addLine(to: CGPoint(x: size.width, y: size.height))
        crossPath.move(to: CGPoint(x: 0, y: size.height))
        crossPath.addLine(to: CGPoint(x: size.width, y: 0))
//        crossPath.close()
        
        self.path = crossPath.cgPath
        self.strokeColor = fillColor
        self.lineWidth = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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

protocol FlippableView: UIView {
    var isFlipped: Bool {get set}
    var flipCompletionHandler: ((FlippableView) -> Void)? {get set}
    func flip()
}

extension UIResponder {
    func responderChain() -> String {
        guard let next = next else {
            return String(describing: Self.self)
        }
        return String(describing: Self.self) + "->" + next.responderChain()
    }
}

//MARK: Класс, описывающий карточку, ее лицевую и заднюю сторону.
class CardView<ShapeType: ShapeLayerProtocol>: UIView, FlippableView {
    
    var isFlipped: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var flipCompletionHandler: ((FlippableView) -> Void)? = { card in
        card.superview?.bringSubviewToFront(card)
    }
    
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        achorPoint.x = touches.first!.location(in: window).x - frame.minX
        achorPoint.y = touches.first!.location(in: window).y - frame.minY
        startTouchPoint = frame.origin
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.frame.origin.x = touches.first!.location(in: window).x - achorPoint.x
        self.frame.origin.y = touches.first!.location(in: window).y - achorPoint.y
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.frame.origin == startTouchPoint {
            flip() }
//        UIView.animate(withDuration: 1) {
//            self.frame.origin = self.startTouchPoint
//            if self.transform.isIdentity {
//                self.transform = CGAffineTransform(rotationAngle: .pi)
//            } else {
//                self.transform = .identity
//            }
//        }
    }
    
    
    
    let margin = 10
    lazy var frontSideView: UIView = self.getFrontSideView()
    lazy var backSideView: UIView = self.getBackSideView()
    
    //MARK: Метод, возвращающий лицевое представление
    func getFrontSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.layer.masksToBounds = true
        
        let frontSideView = UIView(frame: CGRect(x: margin, y: margin, width: Int(view.bounds.width) - margin * 2, height: Int(view.bounds.height) - margin * 2))
        
//        let frontSideLayer = shapeType
        frontSideView.layer.addSublayer(ShapeType(size: frontSideView.frame.size, fillColor: color.cgColor))
        view.addSubview(frontSideView)
        return view
//        let frontSidePath = UIBezierPath(rect: CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>))
                                            
//        (frame: CGRect(x: magrin, y: magrin, width: ((CGFloat(view.bounds.width) - CGFloat(magrin))), height: (CGFloat(view.bounds.height) - CGFloat(magrin))
    }
    
    //MARK: Метод, возвращающий представление задней стороны
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



class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        let firstCardView = CardView<CircleShape>(frame: CGRect(x: 0, y: 0, width: 120, height: 150), color: .red)
        view.addSubview(firstCardView)
        let secondCardView = CardView<CrossShape>(frame: CGRect(x: 170, y: 0, width: 120, height: 150), color: .blue)
        secondCardView.isFlipped = true
        view.addSubview(secondCardView)
        
//        view.addSubview(CardView<CircleShape>.init(frame: view.bounds, color: .white).getFrontSideView(shapeType: circleShape))
//        view.layer.addSublayer(CircleShape(size: CGSize(width: 200, height: 150), fillColor: UIColor.systemGray.cgColor))
//        view.layer.addSublayer(SquareShape(size: CGSize(width: 200, height: 150), fillColor: UIColor.gray.cgColor))
//        view.layer.addSublayer(CrossShape(size: CGSize(width: 300, height: 300), fillColor: UIColor.gray.cgColor))
//        view.layer.addSublayer(FillShape(size: CGSize(width: 400, height: 200), fillColor: UIColor.green.cgColor))
//        view.layer.addSublayer(BackSideCircle(size: CGSize(width: 200, height: 500), fillColor: UIColor.red.cgColor))
//        view.layer.addSublayer(BackSideLine(size: CGSize(width: 200, height: 500), fillColor: UIColor.blue.cgColor))
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
