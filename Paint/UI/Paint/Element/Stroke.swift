//
//  Stroke.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/4.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

class Stroke: Mark {
    var color: UIColor?
    
    var size: CGFloat?
    
    var location: CGPoint? {
        set {}
        get {
            if childs.count > 0 {
                return childs[0].location
            } else {
                return CGPoint(x: 0, y: 0)
            }
        }
    }
    
    var count: Int? {
        get {
            return childs.count
        }
    }
    
    var lastChild: Mark? {
        get {
            return childs.last
        }
    }
    
    var childs: [Mark] = []
    
    
    func addMark(_ mark: Mark) {
        childs.append(mark)
    }
    
    func removeMark(_ mark: Mark) {
        if let index = childs.index(where: { (item) -> Bool in
            isMarkEqual(lhs: item, rhs: mark)
        }) {
            childs.remove(at: index)
        } else {
            childs.forEach({ (item) in
                item.removeMark(mark)
            })
        }
    }
    
    func childMark(at index: Int) -> Mark? {
        if index > childs.count || index < 0 {
            return nil
        } else {
            return childs[index]
        }
    }
    
    func accpetMarkVisitor(_ visitor: MarkVisitor) {
        childs.forEach { (mark) in
            mark.accpetMarkVisitor(visitor)
        }
        visitor.visitorStroke(self)
    }
    
    func enumeratorMarkUsingBlock(_ block: (Mark, UnsafeMutablePointer<Bool>) -> Void) {
        let container = MarkContainer(with: self)
        var stop = false
        for mark in container.allObject() {
            block(mark, &stop)
            if stop {
                break
            }
        }
    }
    
    func drawWithContext(_ context: CGContext) {
        guard let rLocation = location, let rSize = size, let rColor = color else {
            return
        }
        context.move(to: rLocation)
       
        childs.forEach { (mark) in
            mark.drawWithContext(context)
        }
        context.setLineWidth(rSize)
        context.setLineCap(.round)
        context.setStrokeColor(rColor.cgColor)
        context.strokePath()
    }
    private func isMarkEqual(lhs: Mark, rhs: Mark) -> Bool {
        return lhs.count == rhs.count && lhs.location == rhs.location && lhs.size == rhs.size && lhs.color == rhs.color && lhs.lastChild === rhs.lastChild
    }
    
    // MARK: NSCopying
    init(_ model: Stroke) {
        self.color = model.color
        self.size = model.size
        self.childs = model.childs
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Stroke(self)
    }
    
    // MARK: Codable
    enum CodingKeys: String, CodingKey {
        case color
        case size
        case childs
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let hexColor = try? container.decode(Int.self, forKey: .color) {
            self.color = UIColor.color(with: hexColor)
        }
        self.size = try? container.decode(CGFloat.self, forKey: .size)
        self.childs = try container.decode([Mark].self, forKey: .childs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let hexColor = color?.hex()
        try container.encode(hexColor, forKey: .color)
        try container.encode(size, forKey: .size)
        try container.encode(childs, forKey: .childs)
    }
    
    // MARK: 工具类
    class MarkContainer {
        private var stack: [Mark] = []
        
        init(with mark: Mark) {
            traverseAndBuildStackWithMark(mark)
        }
        
        func allObject() -> [Mark] {
            return stack.reversed()
        }
        
        func traverseAndBuildStackWithMark(_ mark: Mark) {
            stack.append(mark)
            let index: Int? = mark.count
            guard let _ = index else {
                return
            }
            var rIndex: Int = index! - 1
            while let sMark = mark.childMark(at: rIndex) {
                traverseAndBuildStackWithMark(sMark)
                rIndex -= 1
            }
        }
    }
}


