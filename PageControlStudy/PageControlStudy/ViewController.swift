//
//  ViewController.swift
//  PageControlStudy
//
//  Created by 장주명 on 2020/07/30.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //이미지 출력용 아웃렛 변수
    @IBOutlet weak var imgView: UIImageView!
    //페이지 컨트롤 용 아웃렛 변수
    @IBOutlet weak var pageControl: UIPageControl!
    
    var images = ["01.png","02.png","03.png","04.png","05.png","06.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //페이지 컨트롤의 전체 페이지를 images배열의 전체 개수 값으로 설정
        pageControl.numberOfPages = images.count
        
        //페이지 컨트롤의 현재 페이지 설정
        pageControl.currentPage = 0
        
        //페이지 표시 색상을 초록색으로 설정
        pageControl.pageIndicatorTintColor = UIColor.green
        
        //현재 페이지 색상을 빨간색으로 설정
        pageControl.currentPageIndicatorTintColor = UIColor.red
        
        //처음 이미지 뷰 설정
        imgView.image = UIImage(named: images[0])
    }

    //페이지가 변하면 호출된다.
    @IBAction func pageChange(_ sender: UIPageControl) {
        //images라는 배열에서 pageControl이 가르키는 현재 페이지에 해당하는 imageView를 할당한다.
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
}

