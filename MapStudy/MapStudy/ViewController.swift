//
//  ViewController.swift
//  MapStudy
//
//  Created by 장주명 on 2020/07/29.
//  Copyright © 2020 C0deWave. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var lblLocationInfo1: UILabel!
    @IBOutlet weak var lblLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        
        //상수 locationManager의 델리게이트를 self로 합니다.
        locationManager.delegate = self
        //정확도를 최고로 설정합니다.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //위치데이터를 추적하기 위해 사용자에게 승인을 요구합니다.
        locationManager.requestWhenInUseAuthorization()
        //위치 업데이트를 시작합니다.
        locationManager.startUpdatingLocation()
        //위치보기값을 true로 합니다.
        myMap.showsUserLocation = true
    }

    //지도의 위치를 업데이트 합니다.
    func goLocation(latitudeValue:CLLocationDegrees,
                    longitudeValue:CLLocationDegrees,
                    delta span : Double)->CLLocationCoordinate2D{
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    //위치가 업데이트 되었을때 지도에 위치를 나타내기 위해서 사용하는 함수입니다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            //placemarks의 첫 부분만 pm상수로 대입합니다.
            //인터넷이 없으면 에러가 나타납니다.
            let pm = placemarks!.first
            //pm상수에서 나라값을 country에 대입합니다.
            let country = pm!.country
            //문자열 address에 country상수값을 대입합니다.
            var address:String = country!
            //pm상수에서 지역 값이 존재하면 address문자열에 더해줍니다.
            if pm!.locality != nil{
                address += " "
                address += pm!.locality!
            }
            //pm문자열에서 도로값이 존재하면 address값에 추가합니다.
            if pm!.thoroughfare != nil{
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재위치"
            self.lblLocationInfo2.text = address
        })
        //마지막으로 위치가 업데이트 되는 것을 멈추게 합니다.
        locationManager.stopUpdatingLocation()
    }
    
    func setAnnotation(latitudeValue:CLLocationDegrees,
                       longitudeValue:CLLocationDegrees,
                       delta span : Double,
                       title strTitle : String,
                       subtitle strSubtitle:String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation()
        
        }else if sender.selectedSegmentIndex == 1{
            setAnnotation(latitudeValue: 37.1458, longitudeValue: 127.0671, delta: 1, title: "오산역", subtitle: "오산에 있음")
            lblLocationInfo1.text = "지금 보고계신 위치"
            lblLocationInfo2.text = "경기도 오산시 오산역"
        }else if sender.selectedSegmentIndex == 2{
            setAnnotation(latitudeValue: 37.4496, longitudeValue: 127.1266, delta: 1, title: "가천대", subtitle: "가천대학교 글로벌 캠퍼스")
            lblLocationInfo1.text = "지금 보고계신 위치"
            lblLocationInfo2.text = "경기 성남시 수정구 가천대학교"
        }else if sender.selectedSegmentIndex == 3{
            setAnnotation(latitudeValue: 37.4555, longitudeValue: 127.1292, delta: 1, title: "우리집", subtitle: "자취방입니다.")
            lblLocationInfo1.text = "지금 보고계신 위치"
            lblLocationInfo2.text = "경기 성남시 수정구 복정로 32번길 38번지 203호"
        }
    }
    
}

