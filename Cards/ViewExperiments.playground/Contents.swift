//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
       setupViews()
    }
    
    private func setupViews() {
        self.view = getRootView()
        let redView = getRedView()
        let greenView = getGreenView()
        let whiteView = getWhiteView()
        let pinkView = getPinkView()
        self.view.addSubview(redView)
        redView.addSubview(greenView)
        redView.addSubview(whiteView)
        self.view.addSubview(pinkView)
        set(view: greenView, toCenterOfView: redView)
//        set(view: whiteView, toCenterOfView: redView)
//        greenView.center = redView.center
        whiteView.center = greenView.center
    }
    
    private func set(view moveView: UIView, toCenterOfView baseView: UIView) {
        moveView.center = CGPoint(x: baseView.bounds.midX, y: baseView.bounds.midY)
//        let moveViewWidht = moveView.frame.width
//        let moveViewHeight = moveView.frame.height
//
//        let baseViewWidht = baseView.bounds.width
//        let baseViewHeight = baseView.bounds.height
//
//        let newXCoorinate = (baseViewWidht - moveViewWidht) / 2
//        let newYCoordinate = (baseViewHeight - moveViewHeight) / 2
//
//        moveView.frame.origin = CGPoint(x: newXCoorinate, y: newYCoordinate)
    }
    
    private func getRootView() -> UIView {
        view = UIView()
        view.backgroundColor = .gray
        return view
    }
    
    private func getRedView() -> UIView {
        let redView = UIView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
        redView.backgroundColor = .red
        redView.transform = CGAffineTransform(rotationAngle: .pi / 3)
//        redView.clipsToBounds = true
        return redView
    }
    
    private func getGreenView() -> UIView {
        let greenView = UIView(frame: CGRect(x: 100, y: 100, width: 180, height: 180))
        greenView.backgroundColor = .green
        return greenView
    }
    
    private func getWhiteView() -> UIView {
        let whiteView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        whiteView.backgroundColor = .white
        return whiteView
    }
    
    private func getPinkView() -> UIView {
        let pinkView = UIView(frame: CGRect(x: 50, y: 300, width: 100, height: 100))
        pinkView.backgroundColor = .systemPink
        pinkView.layer.borderWidth = 5
        pinkView.layer.borderColor = UIColor.white.cgColor
        pinkView.layer.cornerRadius = 20
        pinkView.layer.shadowOpacity = 0.95
        pinkView.layer.shadowRadius = 5
        pinkView.layer.shadowOffset = CGSize(width: 10, height: 20)
        pinkView.layer.shadowColor = UIColor.green.cgColor
        pinkView.layer.opacity = 0.8
        pinkView.layer.backgroundColor = UIColor.systemPink.cgColor
        let layer = CALayer()
        layer.backgroundColor = UIColor.black.cgColor
        layer.frame = CGRect(x: 30, y: 10, width: 20, height: 20)
        layer.cornerRadius = 10
        pinkView.layer.addSublayer(layer)
        pinkView.transform = CGAffineTransform(translationX: 100, y: 5).rotated(by: .pi / 3).scaledBy(x: 0.5, y: 0.5)
//        pinkView.transform = CGAffineTransform.identity
//        pinkView.transform = CGAffineTransform(scaleX: 1.5, y: 0.7)
//        print(pinkView.frame)
//        pinkView.transform = CGAffineTransform(rotationAngle: .pi / 4)
//        print(pinkView.frame)
        return pinkView
    }

}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
