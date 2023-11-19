//
//  MainPageViewController.swift
//
//  Created by Saba Gogrichiani on 18.11.23.
//

import UIKit

final class MainPageViewController: UIViewController {
    
    private var facts = [Fact]()
    private let viewModel = MainPageViewModel()
    
    // MARK: - UI
    private var factsTable: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var rotatingCat: RotatingImageView = {
        let imageView = RotatingImageView()
        imageView.image = UIImage(systemName: "cat.circle.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        factsTable.frame = view.bounds
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        setupUI()
        setupViewModel()
        rotatingCat.startRotating()
        viewModel.viewDidLoad()
        setupTitle()
    }
    
    private func setupUI() {
        setUpBackgroundColor()
        setUpTableView()
        setUpActivityIndicator()
    }
    
    private func setUpBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func setUpTableView() {
        view.addSubview(factsTable)
        factsTable.delegate = self
        factsTable.dataSource = self
    }
    
    private func setUpActivityIndicator() {
        view.addSubview(rotatingCat)
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
    }
    
    private func setupTitle(){
        title = "Facts"
    }
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let fact = facts[indexPath.row]
        cell.textLabel?.text = "🐱 \(fact.fact)"
        return cell
    }
}

extension MainPageViewController: MainPageViewModelDelegate {
    func factsFetched(_ facts: [Fact]) {
        self.facts = facts
        DispatchQueue.main.async {
            self.factsTable.reloadData()
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

