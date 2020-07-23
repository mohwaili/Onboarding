//
//  OnboardingCarouselBottomSheet.swift
//  GenericCarousel
//
//  Created by Mohammed Al Waili on 23/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

class OnboardingCarouselBottomSheet: UIView {

    private lazy var previousButton: UIButton = createPreviousButton()
    private lazy var nextButton: UIButton = createNextButton()
    private lazy var titleLabel: UILabel = createTitleLabel()
    
    enum ActionType {
        case next
        case previous
    }
    
    typealias ButtonTapHandler = (ActionType) -> Void
    var buttonTapHandler: ButtonTapHandler?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(previousButton)
        addSubview(nextButton)
        
        // Label constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        ])
        
        // Buttons constraints
        NSLayoutConstraint.activate([
            previousButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            previousButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 16)
        ])
        
        accessibilityIdentifier = AccessibilityIdentifiers.Carousel.bottomSheetId
    }
    
    func setTitleLabel(_ title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Actions
    
    @objc private func previousButtonTapped(_ sender: UIButton) {
        buttonTapHandler?(.previous)
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        buttonTapHandler?(.next)
    }

}

// MARK: - Components
extension OnboardingCarouselBottomSheet {
 
    private func createPreviousButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Previous", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(previousButtonTapped(_:)), for: .touchUpInside)
        button.accessibilityIdentifier = AccessibilityIdentifiers.Carousel.bottomSheetPreviousButtonId
        return button
    }
    
    private func createNextButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        button.accessibilityIdentifier = AccessibilityIdentifiers.Carousel.bottomSheetNextButtonId
        return button
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
}
