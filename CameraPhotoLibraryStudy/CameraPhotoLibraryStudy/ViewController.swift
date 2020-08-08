//
//  ViewController.swift
//  CameraPhotoLibraryStudy
//
//  Created by 장주명 on 2020/08/08.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    //불러온 사진을 저장할 변수
    var captureImage : UIImage!
    //녹화란 비디오의 URL을 저장할 변수
    var videoURL : URL!
    //이미지의 저장 여부를 나타낼 변수
    var flagImageSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //경고 표시용 메서드
    func myAlert(_ title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //사진 촬영 코드 작성
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        //카메라의 사용 가능여부를 확인합니다.
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            //이미지 피커의 소스타입을 camera로 지정합니다.
            imagePicker.sourceType = .camera
            //미디어 타입을 아래와 같이 설정합니다.
            imagePicker.mediaTypes = [kUTTypeImage as String]
            //편집은 허용하지 않습니다.
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }else{
            myAlert("카메라가 작동하지 않습니다.", message: "카메라에 접근이 되지 않습니다.")
        }
    }
    
    //사진 불러오기 코드 작성하기
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            //이미지 피커의 소스타입을 camera로 지정합니다.
            imagePicker.sourceType = .photoLibrary
            //미디어 타입을 아래와 같이 설정합니다.
            imagePicker.mediaTypes = [kUTTypeImage as String]
            //편집은 허용하지 않습니다.
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
            
        }else{
            myAlert("앨범이 작동하지 않습니다.", message: "앨범에 접근이 되지 않습니다.")
        }
    }
    @IBAction func btnRecordVideoFromCamera(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            //이미지 피커의 소스타입을 camera로 지정합니다.
            imagePicker.sourceType = .camera
            //미디어 타입을 아래와 같이 설정합니다.
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            //편집은 허용하지 않습니다.
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
            
        }else{
            myAlert("카메라가 작동하지 않습니다.", message: "카메라에 접근이 되지 않습니다.")
        }
    }
    @IBAction func btnLoadVideoFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            //이미지 피커의 소스타입을 camera로 지정합니다.
            imagePicker.sourceType = .photoLibrary
            //미디어 타입을 아래와 같이 설정합니다.
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            //편집은 허용하지 않습니다.
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
            
        }else{
            myAlert("앨범이 작동하지 않습니다.", message: "앨범에 접근이 되지 않습니다.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //1 미디어의 종류를 확인합니다.
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        //2 미디어의 종류가 이미지인 경우
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            //3사진을 가져와서 captureImage에 저장합니다.
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            //4 가져온 사진을 포토 라이브러리에 저장합니다.
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imgView.image = captureImage
            
            //5 미디어의 종류가 비디오인 경우
        }else if mediaType.isEqual(to: kUTTypeMovie as NSString as String){
            //6 비디오를 앨범에 저장합니다.
            if flagImageSave {
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        
        //7 현재의 뷰 컨트롤러를 제거합니다. 즉 뷰에서 이미지 피커화면을 제거하여 초기 뷰를 보여줍니다.
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

}

