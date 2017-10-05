//
//  MarkRenderer.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/4.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

class MarkRenderer: MarkVisitor {
    private var context: CGContext
    private var shouldMoveContextToDot: Bool = true
    
    init(with context: CGContext) {
       self.context = context
    }
    
    func visitorMark(_ mark: Mark) {
        
    }
    
    func visitorVertex(_ verter: Vertex) {
        if let location = verter.location {
            if (shouldMoveContextToDot) {
                context.move(to: location)
                shouldMoveContextToDot = false;
            } else {
                context.addLine(to: location)
            }
        }
    }
    
    func visitorDot(_ dot: Dot) {
        guard let rLocation = dot.location, let rSize = dot.size, let rColor = dot.color else {
            return
        }
        let frame = CGRect(origin: CGPoint(x: rLocation.x - rSize/2.0, y: rLocation.y - rSize/2.0), size: CGSize(width: rSize, height: rSize))
        context.setFillColor(rColor.cgColor)
        context.fillEllipse(in: frame)
    }
    
    func visitorStroke(_ stroke: Stroke) {
        guard let rSize = stroke.size, let rColor = stroke.color else {
            return
        }
        context.setLineWidth(rSize)
        context.setLineCap(.round)
        context.setStrokeColor(rColor.cgColor)
        context.strokePath()
        shouldMoveContextToDot = true
    }
    
    
}
