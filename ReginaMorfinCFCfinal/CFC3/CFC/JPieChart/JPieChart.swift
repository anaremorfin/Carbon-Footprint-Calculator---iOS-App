//
//  JPieChart.swift
//  CFC
//
//  Created by Regina on 08/05/22.
//  Based on "PieChart" by Javed Multani from TechnoTouch Infotech. on 03/03/22
//

import Foundation
import UIKit

class JPieChart : UIView {
    
    private let animationDuration: CGFloat = 1.0
    @IBOutlet var chartContainer: UIView!
    private var currentValue: CGFloat = 0.0
    private var layers : [CAShapeLayer]! = [CAShapeLayer]()
    private var currentAnimationIndex  = 0
    public var lineWidth : CGFloat = 1.0
    private  var data: [JPieChartDataSet]!
    
    private func initialize(){
        self.chartContainer = UIView.init(frame: self.bounds)
        addSubview(chartContainer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func addChartData (data : [JPieChartDataSet]!)
    {
        self.data = data
        let totalValue = self.data.map { $0.percent }.reduce(0, +)
        self.data = self.data.map { return JPieChartDataSet(percent: $0.percent / totalValue, colors: $0.colors) }
        drawChart()
        animateChart()
    }
    
    //Dibuja la gráfica PieChart
    private func drawChart(){
        currentValue = 0.0
        var startAngle : CGFloat = 1.5 * CGFloat.pi
        chartContainer.layer.sublayers = nil
        currentAnimationIndex = 0
        self.layers.removeAll()
        for item in self.data {
            let height : CGFloat = (chartContainer.bounds.height * 0.6)
            let radius =   (height / 2) +  ((chartContainer.frame.size.width * 2) / (8 * height))
            let arcCenter = chartContainer.center
            let angle : CGFloat = (item.percent / 1.0) * 2 * CGFloat.pi
            let endAngle : CGFloat = startAngle + angle
            let path = UIBezierPath(arcCenter: arcCenter,
                                    radius: radius,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
            startAngle = endAngle
            let arcLayer = CAShapeLayer()
            arcLayer.path = path.cgPath
            arcLayer.fillColor = nil
            arcLayer.strokeColor = UIColor.green.cgColor
            arcLayer.lineWidth =  radius * lineWidth
            arcLayer.strokeEnd = 1
            //Utilicé mismo color por lo que gradient no es perceptible
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = CGRect(x: 0, y: 0, width: chartContainer.bounds.size.width, height: chartContainer.bounds.size.height)
            gradientLayer.colors = item.colors.map({ return $0.cgColor }).reversed()
            gradientLayer.locations = [0.0,0.65]
            chartContainer.layer.addSublayer(gradientLayer)
            gradientLayer.mask = arcLayer
            currentValue += item.percent
            self.layers.append(arcLayer)
            arcLayer.isHidden = true
        }
    }
    
    //Animación de gráfica
    private func animateChart(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = CFTimeInterval(self.data[currentAnimationIndex].percent / 1.0 * animationDuration)
        animation.fromValue = 0
        animation.toValue = 1
        animation.delegate = self
        animation.isRemovedOnCompletion = true
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        self.layers[currentAnimationIndex].isHidden = false
        self.layers[currentAnimationIndex].add(animation, forKey: animation.keyPath)
    }
}

extension JPieChart: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            currentAnimationIndex += 1
            if currentAnimationIndex < self.layers.count {
                animateChart()
            }
        }
    }
}

