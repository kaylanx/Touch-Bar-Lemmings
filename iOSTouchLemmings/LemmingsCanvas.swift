//
//  LemmingsCanvas.swift
//  TouchLemmings
//
//  Created by Erik Olsson on 2016-12-10.
//  Copyright © 2016 Erik Olsson. All rights reserved.
//

#if !os(iOS)
import Cocoa
#endif
import SpriteKit

class LemmingsCanvas: SKView {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    let scene = LemmmingsScene(size: frame.size)
    scene.isUserInteractionEnabled = true
    presentScene(scene)
    scene.scaleMode = .resizeFill
    scene.physicsWorld.gravity = CGVector.init(dx: 0, dy: 0)
    scene.physicsWorld.contactDelegate = scene
  }
  
  #if !os(iOS)
  override func touchesBegan(with event: NSEvent) {
    scene?.touchesBegan(with: event)
  }
  
  override func touchesMoved(with event: NSEvent) {
    scene?.touchesMoved(with: event)
  }
  
  override func touchesEnded(with event: NSEvent) {
    scene?.touchesEnded(with: event)
  }
  #endif
  
  
  #if os(iOS)
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    scene?.touchesBegan(touches, with: event)
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    scene?.touchesMoved(touches, with: event)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    scene?.touchesEnded(touches, with: event)
  }
  #endif
}

