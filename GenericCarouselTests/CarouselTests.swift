//
//  CarouselTests.swift
//  GenericCarouselTests
//
//  Created by Mohammed Al Waili on 23/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import XCTest
import EarlGrey
@testable import GenericCarousel

class CarouselScreen: Screen {
    
    @discardableResult
    func assertViewIsVisible() -> Self {
        return assertVisible(AccessibilityIdentifiers.Carousel.rootViewId)
    }
    
    @discardableResult
    func assertBottomSheetVisible() -> Self {
        return assertVisible(AccessibilityIdentifiers.Carousel.bottomSheetId)
    }
    
    @discardableResult
    func assertBottomSheetTitleVisible() -> Self {
        return assertVisible(AccessibilityIdentifiers.Carousel.bottomSheetTitleId)
    }
    
    @discardableResult
    func assertBottomSheetNextButtonVisible() -> Self {
        return assertVisible(AccessibilityIdentifiers.Carousel.bottomSheetNextButtonId)
    }
    
    @discardableResult
    func assertBottomSheetPreviousVisible() -> Self {
        return assertVisible(AccessibilityIdentifiers.Carousel.bottomSheetPreviousButtonId)
    }
    
    @discardableResult
    func tapNextButton() -> Self {
        return performTap(withId: AccessibilityIdentifiers.Carousel.bottomSheetNextButtonId)
    }
    
    @discardableResult
    func assertCarouselPageIsVisible(index: Int) -> Self {
        return assertVisible(AccessibilityIdentifiers.Carousel.Pages.page(index: index), minimumVisiblePercent: 0.1)
    }
    
    @discardableResult
    func assertCarouselPageIsHidden(index: Int) -> Self {
        assertHidden(AccessibilityIdentifiers.Carousel.Pages.page(index: index))
    }
    
}

class CarouselTests: MAUITestCase {

    private lazy var viewModel = OnboardingCarouselContainerViewModel()
    private lazy var viewController = OnboardingCarouselContainerViewController(with: viewModel)
    
    func testView_isLoadedSuccessfully() {
        open(viewController: viewController)
        
        CarouselScreen()
        .assertViewIsVisible()
    }
    
    func testBottomSheet_isVisible() {
        open(viewController: viewController)
        
        CarouselScreen()
        .assertBottomSheetVisible()
    }
    
    func testCarousel_scrollingPages() {
        open(viewController: viewController)
        
        CarouselScreen()
        .assertBottomSheetNextButtonVisible()
        .assertCarouselPageIsVisible(index: 0)
        .assertCarouselPageIsHidden(index: 1)
        .assertCarouselPageIsHidden(index: 2)
        .tapNextButton()
        .assertCarouselPageIsVisible(index: 1)
        .assertCarouselPageIsHidden(index: 0)
        .assertCarouselPageIsHidden(index: 2)
        .tapNextButton()
        .assertCarouselPageIsVisible(index: 2)
        .assertCarouselPageIsHidden(index: 0)
        .assertCarouselPageIsHidden(index: 1)
    }
    

}
