//
//  ViewController.swift
//  AudioStudy
//
//  Created by 장주명 on 2020/08/04.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController ,AVAudioPlayerDelegate
,AVAudioRecorderDelegate{

    
    @IBOutlet weak var pvProgressView: UIProgressView!
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var slVolume: UISlider!
    
    @IBOutlet weak var swRecord: UISwitch!
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var lblRecordTime: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    let playAudioImage = UIImage(named: "play.png")
    let pauseAudioImage = UIImage(named: "pause.png")
    let stopAudioImage = UIImage(named: "stop.png")
    let recordAudioImage = UIImage(named: "record.png")
    
    //Avplayer인스턴스 변수
    var audioPlayer: AVAudioPlayer!
    //재생할 오디오의 파일명 변수
    var audioFile: URL!
    //최대 볼륨 실수형 상수
    let MAX_VOLUME : Float = 10.0
    //타이머를 위한 변수
    var progressTimer: Timer!
    //타이머 변수
    let timePlayerSelector:Selector = #selector(ViewController.updatePlayTime)
    
    //녹음을 위한 변수
    var audioRecoder : AVAudioRecorder!
    var isRecordMode = false
    let timeRecordSelector:Selector = #selector(ViewController.updateRecordTime)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        swRecord.isOn = false
        isRecordMode = false
        
        imageView.image = stopAudioImage
        selectAudioFile()
        if !isRecordMode {
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        }else{
            initRecord()
        }
    }
    
    //재생을 하기 위한 설정을 초기화 한다.
    func initPlay(){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError{
            print("Error-initPlay : \(error)")
        }
        slVolume.maximumValue  = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressView.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slVolume.value
        
        lblEndTime.text = convertNSTimeInterval12String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval12String(0)
        
        setPlayButtons(true, pause: false, stop: false)
    }
    
    //TimeInterval 값을 받아서 문자열로 돌려보내는 함수이다.
    func convertNSTimeInterval12String(_ time:TimeInterval) -> String{
        let min = Int(time/60.0)
        //60으로 남은 나머지를 몫에 대입합니다.
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min,sec)
        return strTime
    }

    func setPlayButtons(_ play:Bool, pause:Bool, stop:Bool){
        btnPlay.isEnabled = play
        btnStop.isEnabled = stop
        btnPause.isEnabled = pause
    }
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        imageView.image = playAudioImage
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector,userInfo: nil,repeats: true)
    }
    
    @objc func updatePlayTime(){
        lblCurrentTime.text = convertNSTimeInterval12String(audioPlayer.currentTime)
        pvProgressView.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        imageView.image = pauseAudioImage
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        imageView.image = stopAudioImage
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval12String(0)
        pvProgressView.progress = 0
        setPlayButtons(true, pause: false, stop: false)
        //타이머를 무효화 합니다.
        progressTimer.invalidate()
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    //오디오 재생이 끝나면 맨 처음상태로 돌아가는 함수를 만듭니다.
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
        imageView.image = stopAudioImage
    }
    
    
    
    
    
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn {
            audioPlayer.stop()
            imageView.image = stopAudioImage
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval12String(0)
            btnRecord.isEnabled = true
            isRecordMode = true
            lblRecordTime.isEnabled = true
        }else{
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval12String(0)
        }
        selectAudioFile()
        if !isRecordMode {
            initPlay()
        }else{
            initRecord()
        }
    }
    
    @IBAction func btnRecord(_ sender: UIButton) {
        if (sender as AnyObject).titleLabel?.text == "Record" {
            audioRecoder.record()
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            imageView.image = recordAudioImage
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector,userInfo: nil,repeats: true)
        }else{
            audioRecoder.stop()
            progressTimer.invalidate()
            imageView.image = stopAudioImage
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
        }
    }
    
    @objc func updateRecordTime(){
        lblRecordTime.text = convertNSTimeInterval12String(audioRecoder.currentTime)
    }
    
    func selectAudioFile(){
        if !isRecordMode{
            audioFile =  Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        }else{
            //녹음 모드일 때는 새 파일인 recordFile.m4a가 생성됩니다.
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
    func initRecord(){
        let recirdSettings = [
            AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey:AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey : 2,
        AVSampleRateKey : 44100.0] as [String : Any]
        
        do {
            audioRecoder = try AVAudioRecorder(url: audioFile, settings: recirdSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        audioRecoder.delegate = self
        
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval12String(0)
        lblCurrentTime.text = convertNSTimeInterval12String(0)
        setPlayButtons(false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print("Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("Error-setActive : \(error)")
        }
    }
    
}










