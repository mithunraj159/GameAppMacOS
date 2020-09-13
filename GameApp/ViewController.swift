//
//  ViewController.swift
//  GameApp
//
//  Created by Mithun Raj on 13/09/20.
//  Copyright © 2020 Mithun Raj. All rights reserved.
//

import Cocoa
import SpriteKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let skView = self.view as? SKView {
            let gameScene = GameScene(size: skView.bounds.size)
            gameScene.scaleMode = .aspectFill
            skView.presentScene(gameScene)
        }

    }

}

