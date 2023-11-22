//
//  BreedViewModel.swift
//  spaceInfo
//
//  Created by Saba Gogrichiani on 22.11.23.
//

import Foundation
import Networking

protocol BreedViewModelDelegate: AnyObject {
    func breedsFetched(_ breeds: [Breed])
    func showError(_ error: Error)
}

final class BreedViewModel {

    // MARK: - Properties
    private var breeds: [Breed]?
    weak var delegate: BreedViewModelDelegate?

    // MARK: - Public Methods
    func viewDidLoad() {
        fetchBreeds()
    }

    // MARK: - Private Methods
    private func fetchBreeds() {
        let urlString = "https://catfact.ninja/breeds?limit=15"
        NetworkService.shared.fetchData(urlString: urlString) { [weak self] (result: Result<BreedResponse, Error>) in
            switch result {
            case .success(let breedResponse):
                self?.breeds = breedResponse.data
                self?.delegate?.breedsFetched(breedResponse.data)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
