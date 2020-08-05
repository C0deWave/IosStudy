//
//  ViewController.swift
//  MoviePlayerStudy
//
//  Created by 장주명 on 2020/08/06.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        let filePath:String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4")
        //앱 내부의 파일명을 NSURL방식으로 변경합니다.
        let url = NSURL(fileURLWithPath: filePath!)
        playVideo(url: url)
    }
    @IBAction func playMP4Movie(_ sender: UIButton) {
        let filePath:String = Bundle.main.path(forResource: "Mountaineering", ofType: "mov")!
        //앱 내부의 파일명을 NSURL방식으로 변경합니다.
        let url = NSURL(fileURLWithPath: filePath)
    
        playVideo(url: url)
        
    }
    @IBAction func playM4vMovie(_ sender: UIButton) {
        let filePath:String = Bundle.main.path(forResource: "twice", ofType: "mp4")!
        //앱 내부의 파일명을 NSURL방식으로 변경합니다.
        let url = NSURL(fileURLWithPath: filePath)
    
        playVideo(url: url)
        
    }
    
    @IBAction func btnPlayExternalMovie(_ sender: UIButton) {
        
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mp4")!
        playVideo(url: url)

    }
    
    private func playVideo(url:NSURL){
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        self.present(playerController, animated: true){
            player.play()
        }
    }
}

