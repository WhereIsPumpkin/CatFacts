//
//  BreedViewController.swift
//  spaceInfo
//
//  Created by Saba Gogrichiani on 19.11.23.
//

import UIKit

final class BreedViewController: UIViewController {

    // MARK: - Properties
    private var breeds = [Breed]()
    private let viewModel = BreedViewModel()

    // MARK: - UI Elements
    private lazy var breedsTable: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "breedCell")
        return tableView
    }()

    private lazy var rotatingCat: RotatingImageView = {
        let imageView = RotatingImageView()
        imageView.image = UIImage(systemName: "cat.circle.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Private Methods
    private func setup() {
        setupUI()
        setupViewModel()
        setupRotatingCat()
    }

    private func setupUI() {
        setUpBackgroundColor()
        setUpTableView()
        setupTitle()
    }

    private func setUpBackgroundColor() {
        view.backgroundColor = .systemBackground
    }

    private func setUpTableView() {
        view.addSubview(breedsTable)
        breedsTable.frame = view.bounds
        breedsTable.delegate = self
        breedsTable.dataSource = self
    }

    private func setupTitle() {
        title = "Breeds"
    }

    private func setupRotatingCat() {
        view.addSubview(rotatingCat)
        configureRotatingCatConstraints()
        rotatingCat.startRotating()
    }

    private func configureRotatingCatConstraints() {
        rotatingCat.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rotatingCat.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rotatingCat.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rotatingCat.widthAnchor.constraint(equalToConstant: 70),
            rotatingCat.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension BreedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath)
        let breed = breeds[indexPath.row]
        cell.textLabel?.text = "🐈 \(breed.breed)"
        return cell
    }
}

extension BreedViewController: BreedViewModelDelegate {
    func breedsFetched(_ breeds: [Breed]) {
        self.breeds = breeds
        DispatchQueue.main.async {
            self.breedsTable.reloadData()
            self.rotatingCat.stopRotating()
        }
    }

    func showError(_ error: Error) {
        print("error")
        DispatchQueue.main.async {
            self.rotatingCat.stopRotating()
        }
    }
}
