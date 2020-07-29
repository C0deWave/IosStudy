//
//  ViewController.swift
//  PickerViewStudy
//
//  Created by 장주명 on 2020/07/28.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit

//피커뷰의 델리게이트 메서드를 이용하기 위해서는 아래 2개의 클래스를 상속 받아야 함
class ViewController: UIViewController , UIPickerViewDelegate,UIPickerViewDataSource{
    
    //총 이미지의 개수를 지정하는 역할을 합니다.
    let MAX_ARRAY_NUM = 10
    // PickerView 의 갯수를 지정하는 변수입니다.
    let PICKER_VIEWCOLUMN = 2
    //PickerView의 세로 길이를 지정하는 역할을 합니다.
    let PICKER_VIEW_HEIGHT:CGFloat = 80
    
    //이미지 배열을 만듭니다.
    var imageArray = [UIImage?]()
    
    //이미지의 이름의 배열입니다.
    var imageFileName = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg","10.jpg"]
    
    //피커뷰 아웃렛 변수
    @IBOutlet weak var pickerImage: UIPickerView!
    //레이블 아웃렛 변수
    @IBOutlet weak var lblImageFileName: UILabel!
    //이미지 뷰 아웃렛 변수
    @IBOutlet weak var imageView: UIImageView!
    
    //피커뷰의 델리게이트 메서드를 사용할 수 있도록 만든다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0 ..< MAX_ARRAY_NUM{
            let Image = UIImage(named: imageFileName[i])
            imageArray.append(Image)
        }
        
        lblImageFileName.text = imageFileName[0]
        imageView.image = imageArray[0]
    }
    
    //피커뷰 메서드 오버라이딩
    //총 피커뷰가 몇개인지 확인하는 역할을 합니다.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEWCOLUMN
    }
    
    //PickerView를 오버라이딩 하면 무조건 넣어야 하는 함수입니다.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    //타이틀 제목을 지정하는 함수
    //피커뷰의 제목을 정한다.
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return imageFileName[row]
//    }
    
    //PickerView의 내용을 이미지로 만들어 줍니다.
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        return imageView
    
    }
    
    //이미지를 변경하고 타이틀을 변경하는 함수
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0){
            lblImageFileName.text = imageFileName[row]
            
        }else{
            imageView.image = imageArray[row]
        }
    }
    
    //PickerView의 세로 길이를 늘려주는 역할을 합니다.
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    

}

