//
//  DetailViewController.swift
//  TableStudy
//
//  Created by 장주명 on 2020/07/31.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblItem: UILabel!
    
    //Main View에서 받을 텍스트를 저장하기 위한 변수 입니다.
    var receiveItem = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblItem.text = receiveItem
    }
    
    //MainView에서 변수를 받기 위한 함수를 추가합니다.
    func receiveItem(_ item: String){
        receiveItem = item
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    //세그웨이를 이용하여 뷰를 이동하는 함수 입니다.
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if segue.identifier  == "sgDetail" {
//            let cell = sender as! UITableViewCell
//            let indexPath = self.tvListView.indexPath(for: cell)
//            
//        }
//    }
//    

}
