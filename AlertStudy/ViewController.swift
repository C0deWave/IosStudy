//
//  ViewController.swift
//  AlertStudy
//
//  Created by 장주명 on 2020/07/28.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let imgOn = UIImage(named: "lamp-on.png")
    
    let imgOff = UIImage(named: "lamp-off.png")
    
    let imgRemove = UIImage(named: "lamp-remove.png")
    
    var isLampOn = true
    
    @IBOutlet weak var lampImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lampImage.image = imgOn
    }

    @IBAction func btnLampOn(_ sender: UIButton) {
        if (isLampOn == true) {
            // 전구가 켜져있을때
            //전구기 켜저 있다고 Alert를 실행함
            let lampOnAlert = UIAlertController(title: "경고", message: "현재 ON 상태입니다.", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "네 알겠습니다.", style: UIAlertAction.Style.default, handler: nil)
            lampOnAlert.addAction(onAction)
            present(lampOnAlert, animated: true, completion: nil)
        }else{
            //전구가 켜져있지 않을떄
            //전구를 켠다
            lampImage.image = imgOn
            isLampOn = true
            
        }
    }
    
    @IBAction func btnLampOff(_ sender: UIButton) {
        if isLampOn{
            let lampOffAlert = UIAlertController(title: "램프끄기", message: "램프를 끄시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let offAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: {
                ACTION in self.lampImage.image = self.imgOff
                self.isLampOn = false
            })
            let cancel = UIAlertAction(title: "아니요", style: UIAlertAction.Style.default, handler: nil)
            
            lampOffAlert.addAction(offAction)
            lampOffAlert.addAction(cancel)
            
            present(lampOffAlert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func btnLampRemove(_ sender: UIButton) {
        let lampRemoveAlert = UIAlertController(title: "램프제거", message: "램프를 제거하시겠습니까??", preferredStyle: UIAlertController.Style.alert)
        
        let offAction = UIAlertAction(title: "아니요 끕니다(off)", style: UIAlertAction.Style.default, handler: {
            ACTION in self.lampImage.image = self.imgOff
            self.isLampOn = false
        })
        let onAction = UIAlertAction(title: "아니요 킵니다.(on)", style: UIAlertAction.Style.default, handler: {
            ACTION in self.lampImage.image = self.imgOn
            self.isLampOn = true
        })
        let removeAction = UIAlertAction(title: "네 제거합니다.", style: UIAlertAction.Style.default, handler: {
            ACTION in self.lampImage.image = self.imgRemove
            self.isLampOn = false
        })
        
        lampRemoveAlert.addAction(offAction)
        lampRemoveAlert.addAction(onAction)
        lampRemoveAlert.addAction(removeAction)
        
        present(lampRemoveAlert, animated: true, completion: nil)
    }
    
}

