//
//  ViewController.swift
//  jj
//
//  Created by 장주명 on 2020/07/26.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var helloIos: UILabel!
    @IBOutlet weak var nameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    //버튼에 대한 액션함수의 추가
    @IBAction func btnSend(_ sender: Any) {
        helloIos.text = "Hello" + nameText.text!
    }
}

