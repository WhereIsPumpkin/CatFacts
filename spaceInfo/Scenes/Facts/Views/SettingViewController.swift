//
//  SettingViewController.swift
//  spaceInfo
//
//  Created by Saba Gogrichiani on 22.11.23.
//

import UIKit

protocol UpdateLimitDelegate: AnyObject {
    func updateLimitInViewModel(newLimit: Int)
}

final class SettingViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: UpdateLimitDelegate?
    private var initialSliderValue: Float = 15
    
    // MARK: - UI Elements
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        return slider
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Limit the amount"
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        slider.value = initialSliderValue
        updateAmountLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isBeingDismissed || self.isMovingFromParent {
            delegate?.updateLimitInViewModel(newLimit: Int(slider.value))
        }
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        setupBackground()
        setUpStackView()
        setUpSlider()
    }
    
    private func setupBackground() {
        view.backgroundColor = .systemBackground
    }
    
    private func setUpStackView() {
        view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        [titleLabel, slider, amountLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func setUpSlider() {
        sliderChanged()
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        slider.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    @objc private func sliderChanged() {
        updateAmountLabel()
    }
    
    private func updateAmountLabel() {
        let sliderValue = String(Int(slider.value))
        amountLabel.text = sliderValue
    }
    
    // MARK: - Public Method
    func setInitialSliderValue(_ value: Float) {
        initialSliderValue = value
    }
}

