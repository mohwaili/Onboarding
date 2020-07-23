//
//  MainViewController.swift
//  GenericCarousel
//
//  Created by Mohammed Al Waili on 21/03/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private lazy var startOnboardingButton: UIButton = createStartButton()
    
    private let viewModel: MainViewModel
    
    init(with viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = viewModel.backgroundColor
        
        view.addSubview(startOnboardingButton)
        NSLayoutConstraint.activate([
            startOnboardingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startOnboardingButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc private func startOnboardingButtonTapped(_ sender: UIButton) {
        let viewModel = OnboardingCarouselContainerViewModel()
        let onboarding = OnboardingCarouselContainerViewController(with: viewModel)
        navigationController?.pushViewController(onboarding, animated: true)
    }

}

// MARK: - UI
extension MainViewController {
    
    private func createStartButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(viewModel.startOnboardingTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(startOnboardingButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
}
