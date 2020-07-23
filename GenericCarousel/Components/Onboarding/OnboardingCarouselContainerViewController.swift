//
//  ViewController.swift
//  GenericCarousel
//
//  Created by Mohammed Al Waili on 21/03/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class OnboardingCarouselContainerViewController: UIViewController, CarouselContainer {

    private lazy var carousel: CarouselViewController<OnboardingCarouselPageViewController> = {
        return .init(viewModels: self.viewModel.pagesViewModels) { [weak self] update in
            if case let .viewModelChanged(viewModel: viewModel, index: index) = update {
                let title = "\(index+1): \(viewModel.name)"
                self?.bottomSheetView.setTitleLabel(title)
            }
        }
    }()
    
    private lazy var bottomSheetView: OnboardingCarouselBottomSheet = createBottomSheet()
    
    private let viewModel: OnboardingCarouselContainerViewModel
    
    init(with viewModel: OnboardingCarouselContainerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        embedCarousel(carousel)
        
        view.addSubview(bottomSheetView)
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        bottomSheetView.buttonTapHandler = { action in
            switch action {
            case .next:
                self.carousel.nextPage()
            case .previous:
                self.carousel.previousPage()
            }
        }
        
    }
    
    @objc private func previousButtonTapped(_ sender: UIButton) {
        carousel.previousPage()
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        carousel.nextPage()
    }
    
}

// MARK: - UI Components

extension OnboardingCarouselContainerViewController {
    
    private func createBottomSheet() -> OnboardingCarouselBottomSheet {
        let view = OnboardingCarouselBottomSheet()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }
    
}
