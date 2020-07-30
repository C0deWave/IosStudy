//
//  ViewController.swift
//  ImageViewStudy
//
//  Created by 장주명 on 2020/07/27.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    //확대 여부를 나타내는 변수
    var isZoom = false
    //켜진전구 이미지가 있는 UIImage 타입의 변수
    var imgOn:UIImage?
    //꺼진 전구 이미지가 있는 UIImage타입의 변수
    var imgOff:UIImage?
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnResize: UIButton!
    
    //뷰를 불러왔을때 처음 초기화하는 함수입니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //전구 변수에 이미지를 할당합니다.
        imgOn = UIImage(named: "lamp_on.png")
        imgOff = UIImage(named: "lamp_off.png")
        
        //기본적으로 켜진 이미지로 지정합니다.
        imgView.image = imgOn
        
    }


    // 버튼의 확대 축소 함수
    @IBAction func btnResizeImage(_ sender: UIButton) {
        let scale:CGFloat = 2.0
        var newWidth:CGFloat, newHeight:CGFloat
        
        if (isZoom) {
            //현재 프레임 너비값을 절반으로 줄입니다.
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale
            btnResize.setTitle("확대", for: .normal)
        }else{
            //현재 프레임 너비 값을 2배로 늘립니다.
            newWidth = imgView.frame.width*scale
            newHeight = imgView.frame.height*scale
            btnResize.setTitle("축소", for: .normal)
        }
        
        imgView.frame.size=CGSize(width: newWidth, height: newHeight)
        isZoom = !isZoom
    }
    
    //버튼의 on off 스위치 함수
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if sender.isOn{
            imgView.image = imgOn
        }else{
            imgView.image = imgOff
        }
    }
}

