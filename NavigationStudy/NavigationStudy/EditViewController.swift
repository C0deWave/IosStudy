//
//  EditViewController.swift
//  NavigationStudy
//
//  Created by 장주명 on 2020/07/31.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit

protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDoone(_ controller: EditViewController, isOn: Bool)
    func didSizeBig(_ controller: EditViewController, isBig: Bool)
}

class EditViewController: UIViewController {
    @IBOutlet weak var lblway: UILabel!
    @IBOutlet weak var txMessage: UITextField!
    @IBOutlet weak var btnSize: UIButton!
    var delegate : EditDelegate?
    var textWayValue = ""
    var textMessage = ""
    var isOn = false
    var isBig = false
    
    @IBOutlet weak var swlsOn: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblway.text = textWayValue
        txMessage.text = textMessage
        
        swlsOn.isOn = isOn
        
        if !isBig {
            btnSize.setTitle("축소합니다.", for: .normal)
            self.isBig = true
        }else{
            btnSize.setTitle("확대합니다.", for: .normal)
            self.isBig = false
        }
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            delegate?.didImageOnOffDoone(self, isOn: isOn)
            delegate?.didSizeBig(self, isBig: isBig)
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        }else{
            isOn = false
        }
    }
    
    @IBAction func btnSizeChange(_ sender: Any) {
        if !isBig {
            btnSize.setTitle("축소합니다.", for: .normal)
            isBig = true
        }else{
            btnSize.setTitle("확대합니다.", for: .normal)
            isBig = false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
