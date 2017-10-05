//
//  Dot.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/4.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

class Dot: Vertex {
    
    override func accpetMarkVisitor(_ visitor: MarkVisitor) {
        visitor.visitorDot(self)
    }
    
    init(_ model: Dot) {
        super.init(location: model.location!)
        self.color = model.color
        self.size = model.size
    }
    
    // MARK: NSCopying
    
    override func copy(with zone: NSZone?) -> Any {
        return Dot(self)
    }
    
    // MARK: Codable
    enum CodingKeys: String, CodingKey {
        case color
        case size
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let hexColor = try? container.decode(Int.self, forKey: .color) {
            self.color = UIColor.color(with: hexColor)
        }
        self.size = try? container.decode(CGFloat.self, forKey: .size)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(color?.hex(), forKey: .color)
        try container.encode(size, forKey: .size)
    }
    
    override func drawWithContext(_ context: CGContext) {
        guard let rLocation = location, let rSize = size, let rColor = color else {
            return
        }
        let frame = CGRect(origin: CGPoint(x: rLocation.x - rSize/2.0, y: rLocation.y - rSize/2.0), size: CGSize(width: rSize, height: rSize))
        context.setFillColor(rColor.cgColor)
        context.fillEllipse(in: frame)
    }

}
