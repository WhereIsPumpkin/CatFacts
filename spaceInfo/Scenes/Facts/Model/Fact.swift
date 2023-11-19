//
//  Fact.swift
//  spaceInfo
//
//  Created by Saba Gogrichiani on 19.11.23.
//

import Foundation

struct FactResponse: Decodable {
    let data: [Fact]
}

struct Fact: Decodable {
    let fact: String
}


