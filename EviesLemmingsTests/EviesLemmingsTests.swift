//
//  EviesLemmingsTests.swift
//  EviesLemmingsTests
//
//  Created by Andy Kayley on 21/06/2020.
//  Copyright © 2020 Erik Olsson. All rights reserved.
//

import XCTest

class EviesLemmingsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  func testDuration() {
    
    let heightOfScene = 818.0
    let distanceHeightOffset = 248.00006103515625
    let distanceRemaining = 569.9999389648438
    
    let distanceRemainingAsAPercentageOfHeight = distanceRemaining / heightOfScene * 100
    
    let duration = distanceRemainingAsAPercentageOfHeight / 100 * 60
    
//    86/100*60
    
    let durationTimeInterval = TimeInterval(duration)
    
    print("distanceRemainingAsAPercentageOfHeight = \(distanceRemainingAsAPercentageOfHeight)")
    print("duration = \(duration)")

    
  }

}
