//
//  Screen.swift
//  GenericCarouselTests
//
//  Created by Mohammed Al Waili on 23/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import XCTest
import EarlGrey

class Screen {

    // MARK: Assertions
    @discardableResult
    func assertVisible(_ accessibilityID: String) -> Self {
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityID)).assert(grey_sufficientlyVisible())
        return self
    }
    
    @discardableResult
    func assertVisible(_ accessibilityID: String, minimumVisiblePercent: CGFloat) -> Self {
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityID)).assert(grey_minimumVisiblePercent(minimumVisiblePercent))
        return self
    }
    
    @discardableResult
    func assertExists(_ accessibilityID: String) -> Self {
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityID)).assert(grey_notNil())
        return self
    }

    @discardableResult
    func assertHidden(_ accessibilityID: String) -> Self {
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityID)).assert(grey_notVisible())
        return self
    }

    @discardableResult
    func assertEnabled(_ accessibilityID: String) -> Self {
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityID)).assert(grey_enabled())
        return self
    }

    @discardableResult
    func assertDisabled(_ accessibilityID: String) -> Self {
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityID)).assert(grey_not(grey_enabled()))
        return self
    }

    @discardableResult
    func assertLabelText(_ accessibilityID: String, _ text: String) -> Self {
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityID)).assert(grey_text(text))
        return self
    }
    
    @discardableResult
    func assertLabelTextExists(_ text: String) -> Self {
        EarlGrey.selectElement(with: grey_text(text)).assert(grey_notNil())
        return self
    }

    @discardableResult
    func assertButtonTitle(_ accessibilityID: String, _ text: String) -> Self {
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityID)).assert(grey_buttonTitle(text))
        return self
    }

    @discardableResult
    func assertTableView(_ accessibilityID: String, hasRowCount rowCount: Int, inSection section: Int) -> Self {
        let cellCountAssert = GREYAssertionBlock(name: "cell count") { (element, error) -> Bool in
            guard let tableView = element as? UITableView, tableView.numberOfSections > section else {
                return false
            }
            let numberOfCells = tableView.numberOfRows(inSection: section)
            return numberOfCells == rowCount
        }

        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityID)).assert(cellCountAssert)
        return self
    }

    // MARK: Actions
    @discardableResult
    func performTap(withId accessibilityID: String) -> Self {
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityID))
            .assert(grey_sufficientlyVisible())
            .perform(grey_tap())
        return self
    }

    @discardableResult
    func performScroll(_ accessibilityID: String, _ edge: GREYContentEdge) -> Self {
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityID)).perform(grey_scrollToContentEdge(.bottom))
        return self
    }
}
