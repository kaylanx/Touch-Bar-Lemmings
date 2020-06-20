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
      if case State.falling = lemmingA.state {
        lemmingA.state = .jumping
      }
      if case State.falling = lemmingB.state {
        lemmingB.state = .jumping
      }
    }
  }
  
  func addLemming(at: CGPoint) {
    let lemming = Lemming()
    scene?.addChild(lemming)
    
    if Bool.random() {
      lemming.position = CGPoint(x: at.x, y: 40)
      lemming.state = .falling
    } else {
      lemming.position = at
      lemming.state = .walking(direction: .left)
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
      let location = CGPoint(x: touch.location(in: self.view).x, y: 14)
      
      if let lemming = lemmingAt(point: location) {
        lemming.toggleState()
      }
      else {
        addLemming(at: location)
      }
      
    }
  }
  
}

