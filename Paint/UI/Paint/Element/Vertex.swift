//
//  Vertex.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/4.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

class Vertex: Mark {
    
    var color: UIColor?
    
    var size: CGFloat?
    
    var location: CGPoint?
    
    var count: Int?
    
    var lastChild: Mark?
    
    init(location: CGPoint) {
        self.location = location
    }
    
    
    func addMark(_ mark: Mark) {
    }
    
    func removeMark(_ mark: Mark) {
    }
    
    func childMark(at index: Int) -> Mark? {
        return nil
    }

    
    func accpetMarkVisitor(_ visitor: MarkVisitor) {
        visitor.visitorVertex(self)
    }
    
    func enumeratorMarkUsingBlock(_ block: (Mark, UnsafeMutablePointer<Bool>) -> Void) {
    }
    
    func drawWithContext(_ context: CGContext) {
        if let location = location {
            context.addLine(to: location)
        }
    }

    // MARK: NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        return Vertex(location:location!)
    }
    
    // MARK: Codable
    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.location = try container.decode(CGPoint.self)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.location)

    }
}
