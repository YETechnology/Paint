//
//  MarkVisitor.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/4.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

protocol MarkVisitor {
    func visitorMark(_ mark: Mark)
    func visitorVertex(_ verter: Vertex)
    func visitorDot(_ dot: Dot)
    func visitorStroke(_ stroke: Stroke)
}
