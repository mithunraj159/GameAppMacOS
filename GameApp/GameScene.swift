//
//  GameScene.swift
//  GameApp
//
//  Created by Mithun Raj on 13/09/20.
//  Copyright © 2020 Mithun Raj. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var timer = Timer()
    let catNode = SKSpriteNode(imageNamed: "cat")
    let scoreNode = SKLabelNode(text: "0")
    var scores = 0
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        addCat()
        addScoreLabel()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addBall), userInfo: nil, repeats: true)
    }
    
    func addCat() {
        catNode.name = "cat"
        catNode.position.x = self.frame.size.width/2
        catNode.position.y = 50
        catNode.setScale(0.2)
        
        catNode.physicsBody = SKPhysicsBody(rectangleOf: catNode.size)
        catNode.physicsBody?.affectedByGravity = false
        catNode.physicsBody?.isDynamic = false
        
        self.addChild(catNode)
    }
    
    @objc func addBall() {
        let random = arc4random_uniform(UInt32(self.size.width))
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.name = "ball"
        ball.position.y = self.size.height
        ball.position.x = CGFloat(random)
        ball.setScale(0.2)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.contactTestBitMask = 1
        
        let moveAction = SKAction.moveTo(y: 0, duration: 5)
        
        let deleteAction = SKAction.removeFromParent()
        
        ball.run(SKAction.sequence([moveAction, deleteAction]))
        
        self.addChild(ball)
    }
    
    func addScoreLabel() {
        scoreNode.fontColor = .white
        scoreNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        addChild(scoreNode)
    }
    
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        catNode.position.x = location.x
    }
    
    override func mouseDragged(with event: NSEvent) {
        let location = event.location(in: self)
        catNode.position.x = location.x
    }
    
    //MARK: - Delegate Method
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeA.name == "ball" {
            nodeA.removeFromParent()
            scores += 1
        } else if nodeB.name == "ball" {
            nodeB.removeFromParent()
            scores += 1
        }
        scoreNode.text = "\(scores)"
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let ball = self.childNode(withName: "ball") else { return }
        
        if ball.position.y < 0 {
            let gameOver = GameOverScene(size: self.size)
            gameOver.scaleMode = .aspectFill
            let transition = SKTransition.doorsOpenVertical(withDuration: 2)
            self.view?.presentScene(gameOver, transition: transition)
        }
    }

}
