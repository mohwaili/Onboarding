//
//  OnboardingCarouselContainerViewModel.swift
//  GenericCarousel
//
//  Created by Mohammed Al Waili on 23/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

class OnboardingCarouselContainerViewModel {
    
    var title: String {
        "Onboarding"
    }
    
    lazy var pagesViewModels: [OnboardingCarouselViewModel] = [
        OnboardingCarouselViewModel(
            name: "First Page",
            color: .red,
            accessibilityIdentifier: AccessibilityIdentifiers.Carousel.Pages.page(index: 0)),
        OnboardingCarouselViewModel(
            name: "Second Page",
            color: .green,
            accessibilityIdentifier: AccessibilityIdentifiers.Carousel.Pages.page(index: 1)),
        OnboardingCarouselViewModel(
            name: "Third Page",
            color: .blue,
            accessibilityIdentifier: AccessibilityIdentifiers.Carousel.Pages.page(index: 2))
    ]
    
}
