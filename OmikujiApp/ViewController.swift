//
//  ViewController.swift
//  OmikujiApp
//
//  Created by ポロリア on 2016/11/12.
//  Copyright © 2016年 nakamura. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // iPhoneを振った音を出すための再生オブジェクトを格納します。
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    var audioPlayer1: AVAudioPlayer = AVAudioPlayer()
    var audioPlayer2: AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var stickView: UIView!
    @IBOutlet weak var stickLabel: UILabel!
    @IBOutlet weak var stickHeight: NSLayoutConstraint!
    @IBOutlet weak var stickBottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var kazumaView: UIView!
    @IBOutlet weak var kazumaHeight: NSLayoutConstraint!
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var bigLabel: UILabel!
    
    
    // アプリで使用する音の準備
    func setupSound() {

        // iPhoneを振った時の音を設定します。大吉
        if let sound = Bundle.main.path(forResource: "hanatsu", ofType: ".mp3") {
            audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            audioPlayer.prepareToPlay()
        }
        // iPhoneを振った時の音を設定します。それ以外
        if let sound1 = Bundle.main.path(forResource: "light_saber3", ofType: ".mp3") {
            audioPlayer1 = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1))
            audioPlayer1.prepareToPlay()
        }
        // iPhoneを振った時の音を設定します。大凶
        if let sound2 = Bundle.main.path(forResource: "levelup", ofType: ".mp3") {
            audioPlayer2 = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound2))
            audioPlayer2.prepareToPlay()
        }
    }
    
    
    
    // まずはおみくじでどんな内容がでてくるかを変数に配列で定義します。
    let resultTextarrey: [String] = [
        "大吉",
        "大凶",
        "小吉",
        "吉",
        "末吉",
        "凶",
        "中吉"
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 音の準備
        setupSound()
    }
    
   /*
    *モーションの関数を定義
    */
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        /*
         * motionEnded関数はシェイク以外のモーションでも呼び出されるので、シェイクモーションの時のみ動作するようにします。
         */
        if motion != UIEventSubtype.motionShake || overView.isHidden == false {
            // シェイクモーション以外では動作させない
            return
        }
        // ランダムで配列の要素を取得する
        let resultNum = Int( arc4random_uniform(UInt32(resultTextarrey.count)) )
        stickLabel.text = resultTextarrey[resultNum]
        
        if resultNum == 0 {
             self.audioPlayer.play()
                    stickBottomMargin.constant = stickHeight.constant * -1
        }
            else if resultNum == 1 {
              self.audioPlayer1.play()
                    stickBottomMargin.constant = stickHeight.constant * -1
        }
            else if resultNum >= 2 {
               self.audioPlayer2.play()
                    stickBottomMargin.constant = kazumaHeight.constant * -1
        }
       
        
        // おみくじ棒下辺の間隔を変えて表示位置を変える

        
        /*
         * アニメーションさせる
         */
        UIView.animate(withDuration: 1.0, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: { (finished: Bool) in
            if resultNum == 1 {
                self.bigLabel.text = self.stickLabel.text
            self.kazumaView.isHidden = false
            }
            else if resultNum >= 0 {
            self.bigLabel.text = self.stickLabel.text
            self.overView.isHidden = false
            }
        })
    }
    
    
    @IBAction func tapRetryButton(_ sender: Any) {
        overView.isHidden = true
        stickBottomMargin.constant = 0
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }


}

