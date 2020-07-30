//
//  ViewController.swift
//  PageControlExam
//
//  Created by 장주명 on 2020/07/30.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var countText = ["1","2","3","4","5","6","7","8","9","10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //처음 테스트를 지정합니다.
        lblCount.text = "1"
        
        //페이지의 개수를 지정한다.
        pageControl.numberOfPages = countText.count
        
        //현재 페이지를 지정
        pageControl.currentPage = 0
        
        //현재 페이지의 색상을 하늘색으로 함
        pageControl.currentPageIndicatorTintColor = UIColor.cyan
        
        // 다른 페이지의 색상을 분홍으로 한다.
        pageControl.pageIndicatorTintColor = UIColor.magenta
        
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        lblCount.text = countText[pageControl.currentPage]
    }
}

