//
//  Breed.swift
//  spaceInfo
//
//  Created by Saba Gogrichiani on 22.11.23.
//

import Foundation

struct BreedResponse: Decodable {
    let data: [Breed]
}

struct Breed: Decodable {
    let breed: String
}
