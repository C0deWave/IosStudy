//
//  AddViewController.swift
//  TableStudy
//
//  Created by 장주명 on 2020/07/31.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var tfAddItem: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    //총 이미지의 개수를 지정하는 역할을 합니다.
    let MAX_ARRAY_NUM = 3
    // PickerView 의 갯수를 지정하는 변수입니다.
    let PICKER_VIEWCOLUMN = 1
    //PickerView의 세로 길이를 지정하는 역할을 합니다.
    let PICKER_VIEW_HEIGHT:CGFloat = 80
    
    var imageFileName = ["cart.png","clock.png","pencil.png"]
    
    var selectItemImage = ""
    
    
    //피커뷰 메서드 오버라이딩
    //총 피커뷰가 몇개인지 확인하는 역할을 합니다.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEWCOLUMN
    }
    
    //PickerView를 오버라이딩 하면 무조건 넣어야 하는 함수입니다.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    //PickerView의 내용을 이미지로 만들어 줍니다.
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let imageView = UIImageView(image: UIImage(named: imageFileName[row]))
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }
    
    //이미지를 변경하고 타이틀을 변경하는 함수
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectItemImage = imageFileName[row]
    }
    
    //PickerView의 세로 길이를 늘려주는 역할을 합니다.
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pickerView.selectedRow(inComponent: 0)
        selectItemImage = "cart.png"
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) {
        items.append(tfAddItem.text!)
        itemsImageFile.append(selectItemImage)
        tfAddItem.text = ""
        //루트뷰 컨트롤러 -> 테이블 뷰로 돌아갑니다.
        _ = navigationController?.popViewController(animated: true)
    }
}
