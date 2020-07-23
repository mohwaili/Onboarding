//
//  OnboardingCarouselPageViewController.swift
//  GenericCarousel
//
//  Created by Mohammed Al Waili on 22/03/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

class OnboardingCarouselPageViewController: UIViewController {
        
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(with name: String) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension OnboardingCarouselPageViewController: CarouselPageProtocol {
    
    func configue(with viewModel: OnboardingCarouselViewModel) {
        view.backgroundColor = viewModel.color
        view.accessibilityIdentifier = viewModel.accessibilityIdentifier
    }
    
}
