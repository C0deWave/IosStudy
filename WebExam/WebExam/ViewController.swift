//
//  ViewController.swift
//  WebExam
//
//  Created by 장주명 on 2020/07/29.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var myWebView: WKWebView!
    
    //url Request는 항상 함수 안에 있어야 합니다.
    func loadWeb(_ url:String){
        let myUrl = URL(string: url)
        let urlRequset = URLRequest(url: myUrl!)
        myWebView.load(urlRequset)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadWeb("http://workflowy.com")
    }


}

