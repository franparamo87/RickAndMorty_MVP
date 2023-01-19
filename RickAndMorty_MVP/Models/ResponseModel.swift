//
//  ResponseModel.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import Foundation

struct ResponseModel<T: Codable>: Codable {
    var info: Info
    var results: [T]
    
    struct Info: Codable {
        var count: Int
        var pages: Int
        var next: String?
        var prev: String?
    }
}
