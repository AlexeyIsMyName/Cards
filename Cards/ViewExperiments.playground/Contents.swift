//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        setupViews()
    }
    
    // настройка представлений сцены
    private func setupViews() {
        self.view = getRootView()
        let redView = getRedView()
        let greenView = getGreenView()
        let whiteView = getWhiteView()
        
        // поворот красного представления
                redView.transform = CGAffineTransform(rotationAngle: .pi/3)
        
        set(view: greenView, toCenterOfView: redView)
        // позиционируем белое представление с помощью свойства center
        whiteView.center = greenView.center
        
        self.view.addSubview(redView)
        redView.addSubview(greenView)
        redView.addSubview(whiteView)
        
        // добавим розовое представление на сцену
        let pinkView = getPinkView()
        self.view.addSubview(pinkView)
    }
    
    // создание корневого представления
    private func getRootView() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }
    
    // создание красного представления
    private func getRedView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 50, width: 200, height: 200)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    }
    
    // создание зеленого представления
    private func getGreenView() -> UIView {
        let viewFrame = CGRect(x: 10, y: 10, width: 160, height: 160)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .green
        return view
    }
    
    // создание представления белого цвета
    private func getWhiteView() -> UIView {
        let viewFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .white
        return view
    }
    
    // создание представления розового цвета
    private func getPinkView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 300, width: 100, height: 100)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .systemPink
        
        
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.cornerRadius = 10
        
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 10, height: 20)
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.opacity = 0.7
//        view.layer.backgroundColor = UIColor.black.cgColor
        
        // создание дочернего слоя
        let layer = CALayer()
        // изменение фонового цвета
        layer.backgroundColor = UIColor.black.cgColor
        // изменение размеров и положения
        layer.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        // изменение радиуса скругления углов слоя
        layer.cornerRadius = 10
        // добавление в иерархию слоев
        view.layer.addSublayer(layer)
        
        /*
        // вывод на консоль размеров представления
        print(view.frame)
        // поворот представления
        view.transform = CGAffineTransform(rotationAngle: .pi/4)
        // вывод на консоль размеров представления
        print(view.frame)
        */
        
//        view.transform = CGAffineTransform(scaleX: 1.5, y: 0.7)
        
//        view.transform = CGAffineTransform(translationX: 100, y: 5)
        
        /*
        view.transform = CGAffineTransform(rotationAngle: .pi/3)
            .scaledBy(x: 2, y: 0.8)
            .translatedBy(x: 50, y: 50)
        
        view.transform = CGAffineTransform.identity
        */
        
//        view.transform = CGAffineTransform(rotationAngle: .pi/4)
//        view.transform = view.transform.inverted()
        
        
        return view
    }
    
    private func set(view moveView: UIView, toCenterOfView baseView: UIView) {
        moveView.center = CGPoint(x: baseView.bounds.midX, y: baseView.bounds.midY)
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
