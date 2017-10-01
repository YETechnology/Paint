//
//  TestObject.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/1.
//  Copyright © 2017年 YE. All rights reserved.
//

import Foundation

struct TestObject: Codable {
    let args: [String: String]
    struct Header: Codable {
        let accept: String
        let encode: String
        let connection: String
        let host: String
        let upgrade: String
        let agent: String
        enum CodingKeys: String, CodingKey {
            case accept = "Accept"
            case encode = "Accept-Encoding"
            case connection = "Connection"
            case host = "Host"
            case upgrade = "Upgrade-Insecure-Requests"
            case agent = "User-Agent"
        }
    }
    let headers: Header
    let origin: String
    let url: String
}


struct PagedBreweries : Codable {
    struct Meta : Codable {
        let page: Int
        let totalPages: Int
        let perPage: Int
        let totalRecords: Int
        enum CodingKeys : String, CodingKey {
            case page
            case totalPages = "total_pages"
            case perPage = "per_page"
            case totalRecords = "total_records"
        }
    }
    
    struct Brewery : Codable {
        let id: Int
        let name: String
    }
    
    let meta: Meta
    let breweries: [Brewery]
}


