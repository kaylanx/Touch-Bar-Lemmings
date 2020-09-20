//
//  GameViewController.swift
//  iOSTouchLemmings
//
//  Created by Andy Kayley on 20/06/2020.
//  Copyright © 2020 Erik Olsson. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let view = self.view as! SKView? {
      
      let scene = LemmmingsScene()
      // Set the scale mode to scale to fit the window
      scene.scaleMode = .aspectFill
      scene.backgroundColor = SKColor.black
      // Present the scene
      view.presentScene(scene)
      
      view.ignoresSiblingOrder = true
      
//      #if DEBUG
//      view.showsFPS = true
//      view.showsNodeCount = true
//      #endif
      
    }
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
