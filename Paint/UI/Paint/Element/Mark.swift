//
//  Mark.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/3.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

protocol Mark: Codable, NSCopying {
    var color: UIColor? { set get }
    var size: CGFloat? { set get }
    var location: CGPoint? { set get }
    var count: Int? { get }
    var lastChild: Mark? { get }
    
//    func copy() -> Mark
    func addMark(_ mark: Mark)
    func removeMark(_ mark: Mark)
    func childMark(at index: Int) ->Mark?
    
    func accpetMarkVisitor(_ visitor: MarkVisitor)
    func enumeratorMarkUsingBlock(_ block: (_ mark: Mark, _ stop: UnsafeMutablePointer<Bool>) -> Void)
    
    func drawWithContext(_ context: CGContext)
}

//func ==(lhs: Mark, rhs: Mark) -> Bool {
//       return lhs.count == rhs.count && lhs.location == rhs.location && lhs.size == rhs.size && lhs.color == rhs.color && lhs.lastChild === rhs.lastChild
//}


