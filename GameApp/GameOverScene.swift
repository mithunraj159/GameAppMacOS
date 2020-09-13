//
//  GameOverScene.swift
//  GameApp
//
//  Created by Mithun Raj on 13/09/20.
//  Copyright © 2020 Mithun Raj. All rights reserved.
//

import Foundation
import  SpriteKit

class GameOverScene: SKScene {
    let playButton = SKSpriteNode(imageNamed: "play")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .orange
        
        let label = SKLabelNode(text: "Game Over")
        label.fontColor = .white
        label.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        addChild(label)
        
        playButton.setScale(0.3)
        playButton.position = CGPoint(x: self.size.width/2, y: self.size.height/4)
        addChild(playButton)
    }
    
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        
        if atPoint(location) == playButton {
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            let transition = SKTransition.flipHorizontal(withDuration: 2)
            self.view?.presentScene(gameScene, transition: transition)
        }
    }
}
