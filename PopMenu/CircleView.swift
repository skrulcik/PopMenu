//
//  CircleView.swift
//  PopMenu
//
//  Created by Scott Krulcik on 3/11/15.
//  Copyright (c) 2015 Scott Krulcik. All rights reserved.
//

import Foundation
import UIKit

enum CirclePosition {
    // Compass directions, and centered
    case Centered, N, S, E, W, NE, SE, SW, NW
}

class CircleView:UIButton {
    var centerStyle:CirclePosition
    var arcColor:UIColor? {
        didSet {
            // Custom colors only work on transparent buttons
            backgroundColor = UIColor.clearColor()
        }
    }
    
    // Overriden initializers
    override init() {
        centerStyle = .Centered
        super.init()
    }
    required init(coder aDecoder: NSCoder) {
        centerStyle = .Centered
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        centerStyle = .Centered
        super.init(frame: frame)
    }
    // Custom Initializers
    init(centerStyle center:CirclePosition) {
        centerStyle = center
        super.init()
        //TODO: Figure out why this is necessary
        centerStyle = center
    }
    init(frame:CGRect, withCenter center:CirclePosition) {
        centerStyle = center
        super.init(frame: frame)
        centerStyle = center
    }
    
    
    override func drawRect(rect: CGRect) {
        // Radius if circle is in not center
        var maxRadius:CGFloat = min(rect.width, rect.height) / 2.0
        // Center coordinates:
        var x:CGFloat
        var y:CGFloat
        switch centerStyle {
        case .Centered:
            x = rect.midX
            y = rect.midY
        case .N:
            x = rect.midX
            y = rect.minY
        case .S:
            x = rect.midX
            y = rect.maxY
        case .E:
            x = rect.maxX
            y = rect.midY
        case .W:
            x = rect.minX
            y = rect.midY
        case .NE:
            x = rect.maxX
            y = rect.minY
        case .SE:
            x = rect.maxX
            y = rect.maxY
        case .SW:
            x = rect.minX
            y = rect.maxY
        case .NW:
            x = rect.minX
            y = rect.minY
        default:
            // Centered
            maxRadius = maxRadius / 2.0
            x = rect.midX
            y = rect.midY
        }
        // Circle to be drawn
        let circ = UIBezierPath(arcCenter: CGPoint(x: x, y: y),
            radius: maxRadius,
            startAngle: 0, endAngle: 2.0*CGFloat(M_PI),
            clockwise: false)
        arcColor?.setFill()
        circ.fill()
    }
}




