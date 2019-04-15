//
//  BgShaper.swift
//  meetMyCat
//
//  Created by Jasper Lin on 2019/4/9.
//  Copyright © 2019 jasperlin1996. All rights reserved.
//

import UIKit

class BgShaper: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.height*0.7))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
    let cats = ["niceCat", "goodCat"]
    func changeImage(_ index: Int){
        if index < cats.count{
            self.image = UIImage(named: cats[index])
        }
    }
}
