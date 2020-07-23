//
//  AccessibilityIdentifiers+Carousel.swift
//  GenericCarousel
//
//  Created by Mohammed Al Waili on 23/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

extension AccessibilityIdentifiers {
    
    struct Carousel {
        
        struct Pages {
            public static func page(index: Int) -> String {
                "\(Carousel.self).\(Pages.self).page\(index)"
            }
        }
        
        public static let rootViewId = "\(Carousel.self).rootViewId"
        public static let bottomSheetId = "\(Carousel.self).bottomSheetId"
        public static let bottomSheetTitleId = "\(Carousel.self).bottomSheetTitleId"
        public static let bottomSheetNextButtonId = "\(Carousel.self).bottomSheetNextButtonId"
        public static let bottomSheetPreviousButtonId = "\(Carousel.self).bottomSheetPreviousButtonId"
    }
    
}
