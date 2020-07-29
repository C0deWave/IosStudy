//
//  ViewController.swift
//  DatePickerStudy
//
//  Created by 장주명 on 2020/07/27.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //타이버가 구동되면 실행할 함수를 지정합니다.
    let timeSelector : Selector = #selector(ViewController.updateTime)
    //타이머의 간격입니다.
    let interval = 1.0
    //타이버가 잘 실행되는지 확인하기 위한 변수입니다.
    var count = 0
    
    var currentTime:String = ""
    var alarmTime:String = ""
    
    var alarmFlag = false
    
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblPickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do anyadditional setup after loading the view.
        
        //각 인수의 정보
        //타이머 간격
        //동작될 view
        //타이머가 구동될때 실행할 함수
        //사용자 정보
        //반복 여부
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    //일정이 선택되면 함수를 실행합니다.
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        
        formatter.dateFormat="yyyy-MM-dd HH:mm EEE"
        currentTime = formatter.string(from: datePickerView.date)
        lblPickerTime.text =
            "선택시간: " + currentTime
    }
    
    //타이머가 실행하는 반복함수입니다.
    @objc func updateTime(){
        //타이머 확인하기
//        lblCurrentTime.text = String(count)
//        count = count + 1
        
        //매 초마다 현재시간 업데이트하기
        let date = NSDate()
        
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        
        alarmTime = fomatter.string(from: date as Date)
        
        lblCurrentTime.text = "현재시간 : " + alarmTime
        
        if (alarmTime == currentTime) {
            if !alarmFlag {
                let alarmAlert = UIAlertController(title: "알림", message: "정해진 시간이 되었습니다.", preferredStyle: UIAlertController.Style.alert)
                
                let offAction = UIAlertAction(title: "네, 알겠습니다.", style: UIAlertAction.Style.default, handler: nil)
                
                alarmAlert.addAction(offAction)
                
                present(alarmAlert, animated: true, completion: nil)
                alarmFlag = true
                
            }
        }else{
            alarmFlag = false
        }
    }
}

