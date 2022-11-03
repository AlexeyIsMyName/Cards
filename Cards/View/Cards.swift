//
//  Cards.swift
//  Cards
//
//  Created by ALEKSEY SUSLOV on 03.11.2022.
//

import UIKit

protocol FlippableView: UIView {
    var isFlipped: Bool { get set }
    var flipCompletionHandler: ((FlippableView) -> Void)? { get set }
    func flip()
}

class CardView<ShapeType: ShapeLayerProtocol>: UIView, FlippableView {
    var isFlipped: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var flipCompletionHandler: ((FlippableView) -> Void)?
    
    // радиус закругления
    var cornerRadius = 20
    
    // внутренний отступ представления
    private let margin: Int = 10
    
    // представление с лицевой стороной карты
    lazy var frontSideView: UIView = self.getFrontSideView()
    // представление с обратной стороной карты
    lazy var backSideView: UIView = self.getBackSideView()
    
    // возвращает представление для лицевой стороны карточки
    private func getFrontSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        
        let shapeView = UIView(
            frame: CGRect(x: margin,
                          y: margin,
                          width: Int(self.bounds.width)-margin * 2,
                          height: Int(self.bounds.height)-margin * 2)
        )
        
        view.addSubview(shapeView)
        
        // создание слоя с фигурой
        let shapeLayer = ShapeType(size: shapeView.frame.size,
                                   fillColor: color.cgColor)
        
        shapeView.layer.addSublayer(shapeLayer)
        
        // скругляем углы корневого слоя
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
    }
    
    // возвращает вью для обратной стороны карточки
    private func getBackSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        //выбор случайного узора для рубашки
        switch ["circle", "line"].randomElement()! {
        case "circle":
            let layer = BackSideCircle(size: self.bounds.size,
                                       fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        case "line":
            let layer = BackSideLine(size: self.bounds.size,
                                     fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        default:
            break
        }
        
        // скругляем углы корневого слоя
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
    }
    
    // цвет фигуры
    var color: UIColor!
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.color = color
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
        setupBorders()
    }
    
    // настройка границ
    private func setupBorders() {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    override func draw(_ rect: CGRect) {
        // удаляем добавленные ранее дочерние представления
        backSideView.removeFromSuperview()
        frontSideView.removeFromSuperview()
        // добавляем новые представления
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
            
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
    }
    
    private var startTouchPoint: CGPoint!
    
    // точка привязки
    internal var anchorPoint1: CGPoint = CGPoint(x: 0, y: 0)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // сохраняем исходные координаты
        startTouchPoint = frame.origin
        
        // изменяем координаты точки привязки
        anchorPoint1.x = touches.first!.location(in: window).x - frame.minX
        anchorPoint1.y = touches.first!.location(in: window).y - frame.minY
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.frame.origin.x = touches.first!.location(in: window).x - anchorPoint1.x
        self.frame.origin.y = touches.first!.location(in: window).y - anchorPoint1.y
        
        if self.frame.origin == startTouchPoint {
            flip()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.frame.origin.x = touches.first!.location(in: window).x - anchorPoint1.x
        self.frame.origin.y = touches.first!.location(in: window).y - anchorPoint1.y
    }
    
    func flip() {
        let fromView = isFlipped ? frontSideView : backSideView
        let toView = isFlipped ? backSideView : frontSideView
        
        UIView.transition(from: fromView,
                          to: toView,
                          duration: 0.5,
                          options: [.transitionFlipFromTop],
                          completion: { _ in
            // обработчик переворота
            self.flipCompletionHandler?(self)
        })
        
        isFlipped.toggle()
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print( self.responderChain() )
//    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesBegan Card")
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesMoved Card")
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesEnded Card")
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
