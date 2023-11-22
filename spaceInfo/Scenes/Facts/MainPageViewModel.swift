//  MainPageViewModel.swift
//  spaceInfo
//
//  Created by Saba Gogrichiani on 19.11.23.

import Foundation
import Networking

// MARK: - Protocol
protocol MainPageViewModelDelegate: AnyObject {
    func factsFetched(_ facts: [Fact])
    func showError(_ error: Error)
}

// MARK: - ViewModel
final class MainPageViewModel {
    // MARK: Properties
    private var facts: [Fact]?
    weak var delegate: MainPageViewModelDelegate?
    var limit: Int = 15
    
    // MARK: Public Methods
    func viewDidLoad() {
        fetchAndPrintFacts()
    }

    func updateLimit(newLimit: Int) {
        limit = newLimit
    }

    // MARK: Private Methods
    private func fetchAndPrintFacts() {
        let urlString = "https://catfact.ninja/facts"
        NetworkService.shared.fetchDataWithLimit(urlString: urlString, limit: limit) { [weak self] (result: Result<FactResponse, Error>) in
            switch result {
            case .success(let factResponse):
                self?.facts = factResponse.data
                self?.delegate?.factsFetched(factResponse.data)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
