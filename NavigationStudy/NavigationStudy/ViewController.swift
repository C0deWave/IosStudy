//
//  ViewController.swift
//  NavigationStudy
//
//  Created by 장주명 on 2020/07/31.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    
    var isOn = true
    var isBig = false
    
    //이미지를 고정값으로 지정해보자
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgView.image = imgOn
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        
        if segue.identifier == "editBarButton"{
            //버튼을 클릭한 경우
            editViewController.textWayValue = "segue: use Button"
        }else{
            //바 버튼을 클릭한 경우
            editViewController.textWayValue = "use bar button"
        }
        editViewController.textMessage = txtMessage.text!
        editViewController.delegate = self
        editViewController.isOn = isOn
        editViewController.isBig = isBig
    }
    
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txtMessage.text = message
    }
    
    func didImageOnOffDoone(_ controller: EditViewController, isOn: Bool) {
        if isOn{
            imgView.image = imgOn
            self.isOn = true
        }else{
            imgView.image = imgOff
            self.isOn = false
        }
    }
    
    
    func didSizeBig(_ controller: EditViewController, isBig: Bool) {
        
        
        let scale:CGFloat = 2.0
        var newWidth:CGFloat, newHeight:CGFloat
        
        if (!isBig) {
            //현재 프레임 너비값을 절반으로 줄입니다.
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale
            self.isBig = true
        }else{
            //현재 프레임 너비 값을 2배로 늘립니다.
            newWidth = imgView.frame.width*scale
            newHeight = imgView.frame.height*scale
            self.isBig = false
        }
        
        imgView.frame.size=CGSize(width: newWidth, height: newHeight)
    }
}

