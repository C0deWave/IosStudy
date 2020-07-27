//
//  ViewController.swift
//  ImageViewExam
//
//  Created by 장주명 on 2020/07/27.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var imageName = ["1.png","2.png","3.png","4.png","5.png","6.png"]

    var imageNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: imageName[imageNumber])
    }

    @IBAction func beforeImage(_ sender: UIButton) {
        if (imageNumber > 0) {
            imageNumber = imageNumber - 1
            imageView.image = UIImage(named: imageName[imageNumber])
        }
    }
    
    @IBAction func nextImagge(_ sender: UIButton) {
        if (imageNumber < 5) {
            imageNumber = imageNumber + 1
            imageView.image = UIImage(named: imageName[imageNumber])
        }
    }
}

