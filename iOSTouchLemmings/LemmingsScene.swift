//
//  LemmingsScene.swift
//  TouchLemmings
//
//  Created by Erik Olsson on 2016-12-11.
//  Copyright © 2016 Erik Olsson. All rights reserved.
//

import SpriteKit

class LemmmingsScene: SKScene, SKPhysicsContactDelegate {
  
  var lemmings = [Lemming]()
  
  var touchStarted: TimeInterval?
  let longTapTime: TimeInterval = 0.5
  
  func didBegin(_ contact: SKPhysicsContact) {
    if let lemmingA = contact.bodyA.node as? Lemming,
      let lemmingB = contact.bodyB.node as? Lemming {
      
      if case State.walking(let direction) = lemmingA.state {
        lemmingA.state = .walking(direction: direction.theOtherDirection())
      }
      
      if case State.walking(let direction) = lemmingB.state {
        lemmingB.state = .walking(direction: direction.theOtherDirection())
      }
    }
  }
  
  func addLemming(at location: CGPoint) {
    let lemming = Lemming()
    scene?.addChild(lemming)
    
    if location.y > 40 {
      lemming.position = location
      lemming.state = .parachuting
    } else {
      lemming.position = CGPoint(x: location.x, y: 14)
      lemming.state = .walking(direction: Bool.random() ? .left : .right)
    }
    
    lemmings.append(lemming)
  }
  
  func lemmingAt(point: CGPoint) -> Lemming? {
    return lemmings.filter { $0.contains(point) }.first
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let _ = touches.first, let event = event {
      touchStarted = event.timestamp
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first, let event = event {
      let location = CGPoint(x: touch.location(in: self.view).x, y: 14)
      let timeEnded = event.timestamp
      if timeEnded - touchStarted! >= longTapTime {
        let deadline = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
          self.scene?.removeAllChildren()
        }
      }
      if let lemming = lemmingAt(point: location) {
        lemming.position = location
      }
    }
    
  }
  
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let location = touch.location(in: self)
      
      if let lemming = lemmingAt(point: location) {
        lemming.toggleState()
      }
      else {
        addLemming(at: location)
      }
      
    }
  }
  
}

