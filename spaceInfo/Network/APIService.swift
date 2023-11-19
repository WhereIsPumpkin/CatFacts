//
//  APIService.swift
//  spaceInfo
//
//  Created by Saba Gogrichiani on 19.11.23.
//

import UIKit
import Networking

final class APIService {
    static let shared = APIService()
    private let baseURL = "https://catfact.ninja"
    private let networkService = NetworkService()
    
    private init() {}
    
    func fetchFacts(completion: @escaping (Result<[Fact], Error>) -> Void) {
        let urlStr = "\(baseURL)/facts?max_length=50&limit=15"
        networkService.fetchData(urlString: urlStr) { (result: Result<FactResponse, Error>) in
            switch result {
            case .success(let factResponse):
                completion(.success(factResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

