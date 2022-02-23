//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        createBezier(on: view)
    }
    
    var path = UIBezierPath()
    
    
    private func createBezier(on view: UIView) {
        let shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.path = getPath().cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.path = getPathArcCenter().cgPath
    }
    
    private func getPath() -> UIBezierPath {
        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 50, y: 50))
//        path.addLine(to: CGPoint(x: 150, y: 50))
//        path.addLine(to: CGPoint(x: 150, y: 150))
//        path.close()
//        path.move(to: CGPoint(x: 50, y: 70))
//        path.addLine(to: CGPoint(x: 150, y: 170))
//        path.addLine(to: CGPoint(x: 50, y: 170))
//        path.close()
        path.move(to: CGPoint(x: 10, y: 10))
        path.addCurve(to: CGPoint(x: 200, y: 200),
                      controlPoint1: CGPoint(x: 400, y: 20),
                      controlPoint2: CGPoint(x: 20, y: 200))
//        path.close()
//        path.move(to: CGPoint(x: 10, y: 10))
//        path.addLine(to: CGPoint(x: 210, y: 10))
//        path.addLine(to: CGPoint(x: 210, y: 210))
//        path.addLine(to: CGPoint(x: 10, y: 210))
//        path.close()
        let rect = CGRect(x: 50, y: 50, width: 200, height: 200)
//        let path2 = UIBezierPath(rect: rect)
//        let path2 = UIBezierPath(roundedRect: rect, cornerRadius: 30)
//        let path2 = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 30, height: 0))
        //Передаю в качестве аргумента квадрат - получаю круг
//        let path2 = UIBezierPath(ovalIn: rect)
//        path2.close()
        return path
        
    }
    
//    private func getPathArcCenter() -> UIBezierPath {
//        let arcCenterPath = UIBezierPath(arcCenter: CGPoint(x: 200, y: 200), radius: 150, startAngle: .pi/5, endAngle: .pi, clockwise: true)
//        arcCenterPath.close()
////        arcCenterPath.move(to: CGPoint(x: 10, y: 400))
//        return arcCenterPath
//    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
