//
//  SpriteLoader.swift
//  TouchLemmings
//
//  Created by Erik Olsson on 2016-12-10.
//  Copyright © 2016 Erik Olsson. All rights reserved.
//

import SpriteKit

struct SpriteLoader {
  
  static let SpriteSheet = SKTexture(imageNamed: "sprites.png")
  
  static func loadAnimation(name: String) -> [SKTexture] {
    guard let path = Bundle.main.path(forResource: "Atlas", ofType: "plist"),
      let atlas = NSDictionary(contentsOfFile: path),
      let animation = atlas[name] as? [CFDictionary] else {
        fatalError()
    }
    
    return animation.map {
      CGRect(dictionaryRepresentation: $0)!
    }.map {
      print("name = \(name); rect = \($0)")
      return SKTexture(rect: $0, in: SpriteLoader.SpriteSheet)
    }
  }
  
  static func loadWalkingTextures() -> [SKTexture] {
    return loadAnimation(name: "walk")
  }
  
  static func loadBlockingTextures() -> [SKTexture] {
    return loadAnimation(name: "block")
  }
  
  static func loadParachutingTextures() -> [SKTexture] {
    return loadAnimation(name: "parachute")
  }
  
  static func loadFallingTextures() -> [SKTexture] {
    return loadAnimation(name: "falling")
  }
  
  static func loadJumpingTextures() -> [SKTexture] {
    return loadAnimation(name: "jump")
  }
}
