//
//  GameScene.swift
//  moukeyou
//
//  Created by tcs14048 on 2018/09/21.
//  Copyright © 2018年 tcs14048. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene,AVAudioPlayerDelegate {
    
    var timer: Timer?
    var aka_ie:SKSpriteNode!
    var ao_ie:SKSpriteNode!
    var ao_ue:SKSpriteNode!
    var ao_sita:SKSpriteNode!
    var ao_hidari:SKSpriteNode!
    var ao_migi:SKSpriteNode!
    var aka_ue:SKSpriteNode!
    var aka_sita:SKSpriteNode!
    var aka_hidari:SKSpriteNode!
    var aka_migi:SKSpriteNode!
    var minustenyen:SKSpriteNode!
    var minushyakuyen:SKSpriteNode!
    var minusgohyakuyen:SKSpriteNode!
    var goyen:SKSpriteNode!
    var tenyen:SKSpriteNode!
    var gojyuuyen:SKSpriteNode!
    var hyakuyen:SKSpriteNode!
    var gohyakuyen:SKSpriteNode!
    
    //音
    var audioPlayer: AVAudioPlayer!
    var BGMPlayer: AVAudioPlayer!
    
    func addAsteroid() {
        let names = ["gohyakuyen","gojyuuyen","hyakuyen","goyen","minusgohyakuyen","minushyakuyen","minustenyen","tenyen"]
        let index = Int(arc4random_uniform(UInt32(names.count)))
        let name = names[index]
        let asteroid = SKSpriteNode(imageNamed: name)
        let random = CGFloat(arc4random_uniform(UINT32_MAX)) / CGFloat(UINT32_MAX)
        let positionX = frame.width * (random - 0.5)
        asteroid.position = CGPoint(x: positionX, y: frame.height / 2 + asteroid.frame.height)
        asteroid.scale(to: CGSize(width: 70, height: 70))
        addChild(asteroid)
        let move = SKAction.moveTo(y: -frame.height / 2 - asteroid.frame.height, duration: 20.0)
        let remove = SKAction.removeFromParent()
        asteroid.run(SKAction.sequence([move, remove]))
    }

    // これも音
    func playSound(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("rezi")
            return
        }
        
        do {
            // AVBGMPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            // AVBGMPlayerのデリゲートをセット
            audioPlayer.delegate = self
            
            // 音声の再生
            audioPlayer.play()
        } catch {
        }
    }
    func playBGM(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("nezumi")
            return
        }
        
        do {
            // AVAudioPlayerのインスタンス化
            BGMPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            // AVAudioPlayerのデリゲートをセット
            BGMPlayer.delegate = self
            BGMPlayer.numberOfLoops = -1
            
            // 音声の再生
            BGMPlayer.play()
        } catch {
        }
    }
    //音はここまで
    
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    
    override func didMove(to view: SKView) {
        playBGM(name: "nezumi")
        playSound(name: "reji sound")
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.addAsteroid()
        })
        
        //ゲーム画面の背景色を薄緑にする
        self.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.5, alpha:1.0)
        
        //　お店の表示
        self.aka_ie = SKSpriteNode(imageNamed: "aka_ie")
        self.aka_ie.scale(to: CGSize(width: frame.width / 5, height: frame.width / 5))
        self.aka_ie.position = CGPoint(x: frame.midX - view.frame.size.width / 3.5, y: frame.midY + view.frame.size.height / 4)
        addChild(self.aka_ie)
        
        self.ao_ie = SKSpriteNode(imageNamed: "ao_ie")
        self.ao_ie.scale(to: CGSize(width: frame.width / 5, height: frame.width / 5))
        self.ao_ie.position = CGPoint(x: frame.midX + view.frame.size.width / 3.5, y: frame.midY + view.frame.size.height / 4)
        addChild(self.ao_ie)
        
        
        
        //矢印各種の配置と表示
        self.ao_ue = SKSpriteNode(imageNamed: "ao_ue")

        self.ao_ue.scale(to: CGSize(width: frame.width / 20, height: frame.width / 20))
        self.ao_ue.position = CGPoint(x: frame.midX + view.frame.size.width / 3.5, y: frame.midY - view.frame.size.height / 4.2)
        addChild(self.ao_ue)
        
        self.ao_sita = SKSpriteNode(imageNamed: "ao_sita")
        self.ao_sita.scale(to: CGSize(width: frame.width / 20, height: frame.width / 20))
        self.ao_sita.position = CGPoint(x: frame.midX + view.frame.size.width / 3.5, y: frame.midY - view.frame.size.height / 3)
        addChild(self.ao_sita)

        self.ao_hidari = SKSpriteNode(imageNamed: "ao_hidari")
        self.ao_hidari.scale(to: CGSize(width: frame.width / 20, height: frame.width / 20))
        self.ao_hidari.position = CGPoint(x: frame.midX + view.frame.size.width / 4, y: frame.midY - view.frame.size.height / 3.5)
        addChild(self.ao_hidari)
        
        self.ao_migi = SKSpriteNode(imageNamed: "ao_migi")
        self.ao_migi.scale(to: CGSize(width: frame.width / 20, height: frame.width / 20))
        self.ao_migi.position = CGPoint(x: frame.midX + view.frame.size.width / 3.1, y: frame.midY - view.frame.size.height / 3.5)
        addChild(self.ao_migi)
       
        self.aka_ue = SKSpriteNode(imageNamed: "aka_ue")
        self.aka_ue.scale(to: CGSize(width: frame.width / 20, height: frame.width / 20))
        self.aka_ue.position = CGPoint(x: frame.midX - view.frame.size.width / 3.5, y: frame.midY - view.frame.size.height / 4.2)
        addChild(self.aka_ue)
        
        self.aka_sita = SKSpriteNode(imageNamed: "aka_sita")
        self.aka_sita.scale(to: CGSize(width: frame.width / 20, height: frame.width / 20))
        self.aka_sita.position = CGPoint(x: frame.midX - view.frame.size.width / 3.5, y: frame.midY - view.frame.size.height / 3)
        addChild(self.aka_sita)
        
        self.aka_hidari = SKSpriteNode(imageNamed: "aka_hidari")
        self.aka_hidari.scale(to: CGSize(width: frame.width / 20, height: frame.width / 20))
        self.aka_hidari.position = CGPoint(x: frame.midX - view.frame.size.width / 3.1, y: frame.midY - view.frame.size.height / 3.5)
        addChild(self.aka_hidari)
        
        self.aka_migi = SKSpriteNode(imageNamed: "aka_migi")
        self.aka_migi.scale(to: CGSize(width: frame.width / 20, height: frame.width / 20))
        self.aka_migi.position = CGPoint(x: frame.midX - view.frame.size.width / 4, y: frame.midY - view.frame.size.height / 3.5)
        addChild(self.aka_migi)
        
        //お客さん各種を表示
        self.minustenyen = SKSpriteNode(imageNamed: "minustenyen")
        self.minustenyen.scale(to: CGSize(width: frame.width / 8, height: frame.width / 8))
        self.minustenyen.position = CGPoint(x: -190, y: 0)
        addChild(self.minustenyen)
        
        self.minushyakuyen = SKSpriteNode(imageNamed: "minushyakuyen")
        self.minushyakuyen.scale(to: CGSize(width: frame.width / 8, height: frame.width / 8))
        self.minushyakuyen.position = CGPoint(x: -140, y: 0)
        addChild(self.minushyakuyen)
        
        self.minusgohyakuyen = SKSpriteNode(imageNamed: "minusgohyakuyen")
        self.minusgohyakuyen.scale(to: CGSize(width: frame.width / 8, height: frame.width / 8))
        self.minusgohyakuyen.position = CGPoint(x: -90, y: 0)
        addChild(self.minusgohyakuyen)
        
        self.goyen = SKSpriteNode(imageNamed: "goyen")
        self.goyen.scale(to: CGSize(width: frame.width / 8, height: frame.width / 8))
        self.goyen.position = CGPoint(x: -40, y: 0)
        addChild(self.goyen)
        
        self.tenyen = SKSpriteNode(imageNamed: "tenyen")
        self.tenyen.scale(to: CGSize(width: frame.width / 8, height: frame.width / 8))
        self.tenyen.position = CGPoint(x: 160, y: 0)
        addChild(self.tenyen)
        
        self.gojyuuyen = SKSpriteNode(imageNamed: "gojyuuyen")
        self.gojyuuyen.scale(to: CGSize(width: frame.width / 8, height: frame.width / 8))
        self.gojyuuyen.position = CGPoint(x: 110, y: 0)
        addChild(self.gojyuuyen)
        
        self.hyakuyen = SKSpriteNode(imageNamed: "hyakuyen")
        self.hyakuyen.scale(to: CGSize(width: frame.width / 8, height: frame.width / 8))
        self.hyakuyen.position = CGPoint(x: 60, y: 0)
        addChild(self.hyakuyen)
        
        self.gohyakuyen = SKSpriteNode(imageNamed: "gohyakuyen")
        self.gohyakuyen.scale(to: CGSize(width: frame.width / 8, height: frame.width / 8))
        self.gohyakuyen.position = CGPoint(x: 10, y: 0)
        addChild(self.gohyakuyen)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPaused { return }
        
        // タッチされているオブジェクトから、
        for touch: AnyObject in touches {
            // タッチした場所を取得する。
            let location = touch.location(in: self)
            // タッチされたノードを選択して、ボタンと触れたかを判定する。
            let touchNode = self.atPoint(location)
            // 右のボタンが押されたら右に30px動かす。
            if touchNode == aka_migi {
                // 右に動く動きを指定する。
                let moveToRight = SKAction.moveTo(x: self.aka_ie.position.x + 30, duration: 0.2)
                // 右に動かす。
                aka_ie.run(moveToRight)
                // 左のボタンが押されたら左に30px動かす。
            }else if touchNode == aka_hidari {
                // 左に動く動きを指定する。
                let moveToLeft = SKAction.moveTo(x: self.aka_ie.position.x - 30, duration: 0.2)
                // 左に動く動きを指定する。
                aka_ie.run(moveToLeft)
              
            }
        }
        if isPaused { return }
        
        // タッチされているオブジェクトから、
        for touch: AnyObject in touches {
            // タッチした場所を取得する。
            let location = touch.location(in: self)
            // タッチされたノードを選択して、ボタンと触れたかを判定する。
            let touchNode = self.atPoint(location)
            // 上のボタンが押されたら上に30px動かす。
            if touchNode == aka_ue {
                // 上に動く動きを指定する。
                let moveToTop = SKAction.moveTo(y: self.aka_ie.position.y + 30, duration: 0.2)
                // 上に動かす。
                aka_ie.run(moveToTop)
                // 下のボタンが押されたら左に30px動かす。
            }else if touchNode == aka_sita {
                // 下に動く動きを指定する。
                let moveToDown = SKAction.moveTo(y: self.aka_ie.position.y - 30, duration: 0.2)
                // 下に動く動きを指定する。
                aka_ie.run(moveToDown)
               
            }
        }
        if isPaused { return }
        
        // タッチされているオブジェクトから、
        for touch: AnyObject in touches {
            // タッチした場所を取得する。
            let location = touch.location(in: self)
            // タッチされたノードを選択して、ボタンと触れたかを判定する。
            let touchNode = self.atPoint(location)
            // 右のボタンが押されたら右に30px動かす。
            if touchNode == ao_migi {
                // 右に動く動きを指定する。
                let moveToRight = SKAction.moveTo(x: self.ao_ie.position.x + 30, duration: 0.2)
                // 右に動かす。
                ao_ie.run(moveToRight)
                // 左のボタンが押されたら左に30px動かす。
            }else if touchNode == ao_hidari {
                // 左に動く動きを指定する。
                let moveToLeft = SKAction.moveTo(x: self.ao_ie.position.x - 30, duration: 0.2)
                // 左に動く動きを指定する。
                ao_ie.run(moveToLeft)
                
            }
        }
        if isPaused { return }
        
        // タッチされているオブジェクトから、
        for touch: AnyObject in touches {
            // タッチした場所を取得する。
            let location = touch.location(in: self)
            // タッチされたノードを選択して、ボタンと触れたかを判定する。
            let touchNode = self.atPoint(location)
            // 上のボタンが押されたら上に30px動かす。
            if touchNode == ao_ue {
                // 上に動く動きを指定する。
                let moveToTop = SKAction.moveTo(y: self.ao_ie.position.y + 30, duration: 0.2)
                // 上に動かす。
                ao_ie.run(moveToTop)
                // 下のボタンが押されたら左に30px動かす。
            }else if touchNode == ao_sita {
                // 下に動く動きを指定する。
                let moveToDown = SKAction.moveTo(y: self.ao_ie.position.y - 30, duration: 0.2)
                // 下に動く動きを指定する。
                ao_ie.run(moveToDown)
                
            }
        }

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    }
}
