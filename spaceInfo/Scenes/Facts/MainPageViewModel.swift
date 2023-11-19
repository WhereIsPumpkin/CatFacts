//
//  MainPageViewModel.swift
//  spaceInfo
//
//  Created by Saba Gogrichiani on 19.11.23.
//

import Foundation

protocol MainPageViewModelDelegate: AnyObject {
    func factsFetched(_ facts: [Fact])
    func showError(_ error: Error)
}

final class MainPageViewModel {
    private var facts: [Fact]?
    
    weak var delegate: MainPageViewModelDelegate?
    
    func viewDidLoad() {
        fetchAndPrintFacts()
    }
    
    private func fetchAndPrintFacts() {
        APIService.shared.fetchFacts { [weak self] result in
            switch result {
            case .success(let facts):
                self?.facts = facts
                self?.delegate?.factsFetched(facts)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
