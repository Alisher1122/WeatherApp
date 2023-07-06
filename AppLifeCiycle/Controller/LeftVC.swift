//
//  LeftVC.swift
//  AppLifeCiycle
//
//  Created by Asliddin Mahmudov on 22/07/22.
//

import UIKit
import SwiftyJSON
import Alamofire
import CoreLocation
import RealmSwift


class LeftVC: UIViewController, CLLocationManagerDelegate {
 
    let realm = try! Realm()
    
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!
    
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            collectionView.register(HoursCVC.nib(), forCellWithReuseIdentifier: HoursCVC.id)
        }
    }
    
    var manager:CLLocationManager?
    
    
    var weathers: [Hourly] = []
   
    var nameCity = ""
    var cordinateLat: Double = 41.3455
    var cordinateLong: Double = 69.2845
    var key = "0d5bcc4d8403fbf089b5762f879f058a"
    var currentWeatherApi = ""
    var hourlyForecastApi = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.requestWhenInUseAuthorization()
        manager? .startUpdatingLocation()
        getDatesfromRealm()
        
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location:CLLocationCoordinate2D = manager.location!.coordinate
        cordinateLat = location.latitude
        cordinateLong = location.longitude
        print(cordinateLat)
        print(cordinateLong)
     
        getDatesfromAPI()
        
    }
    
    
    

    
    
    
    func getDatesfromAPI (){
       
        if nameCity == "" {
            currentWeatherApi = "https://api.openweathermap.org/data/2.5/weather?lat=\(cordinateLat)&lon=\(cordinateLong)&appid=\(key)"
            hourlyForecastApi = "https://api.openweathermap.org/data/2.5/forecast?lat=\(cordinateLat)&lon=\(cordinateLong)&appid=\(key)"
            
        } else {
            currentWeatherApi = "https://api.openweathermap.org/data/2.5/weather?q=\(nameCity)&appid=\(key)"
            hourlyForecastApi = "https://api.openweathermap.org/data/2.5/forecast?q=\(nameCity)&appid=\(key)"
        }
        
        
        //MARK: - Request->CurrentData -
    
            AF.request(currentWeatherApi, method: .get).validate().responseDecodable(of: CurrentWeatherData.self, completionHandler: { data in

                if let response = data.value {
                  //  print(response)
                    self.realm.beginWrite()
                    let curWeather = CurrentWeather()
                    
                    let temp = Int((response.main.temp-273.15).rounded())
                    let tempMin = Int((response.main.temp_min-273.15).rounded())
                    let tempMax = Int((response.main.temp_max-273.15).rounded())
                    var desc = ""
                    
                    curWeather.temp1 = temp
                    curWeather.tempMin1 = tempMin
                    curWeather.tempMax1 = tempMax
                    curWeather.cityName1 = response.name
                    for i in  response.weather {
                        desc = i.description
                    }
                    curWeather.desc1 = desc
                    
                    self.realm.add(curWeather)
                    try! self.realm.commitWrite()
                    
                    self.cityNameLbl.text = response.name
                    self.tempLbl.text = "\(temp)°"
                    self.highTempLbl.text = "H: \(tempMax)°"
                    self.lowTempLbl.text = "L: \(tempMin)°"
                    self.weatherLbl.text = desc
                   
                   
                } else {

                }

            })
        
        
        
        //MARK: - Request-> Hourly Forecast -
        AF.request(hourlyForecastApi, method: .get).validate().responseDecodable(of: MainResponse.self, completionHandler: { data in
            
            if let response = data.value {
              //print(response)
                self.weathers = response.list
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } else {

            }

        })
        
    }
    
    func getDatesfromRealm() {
        let weather = realm.objects(CurrentWeather.self)
        for i in weather {
            self.cityNameLbl.text = i.cityName1
            self.tempLbl.text = "\(i.temp1)°"
            self.highTempLbl.text = "H: \(i.tempMax1)°"
            self.lowTempLbl.text = "L: \(i.tempMin1)°"
            self.weatherLbl.text = i.desc1
            print(i.cityName1)
        }
    }
    
    
    
}




//MARK: - UICollectionViewDelegate -
extension LeftVC: UICollectionViewDelegate {


}


//MARK: - UICollectionViewDataSource -
extension LeftVC: UICollectionViewDataSource {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  HoursCVC.id, for: indexPath) as? HoursCVC else { return UICollectionViewCell()}
        cell.updateCell(date: weathers[indexPath.row])
        return cell
    }

}

//MARK: - UICollectionViewDelegateFlowLayout -
extension LeftVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (self.collectionView.frame.width)/5, height: self.collectionView.frame.height*0.9)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}


class CurrentWeather: Object {
    @objc dynamic var temp1: Int = 0
    @objc dynamic var tempMin1: Int = 0
    @objc dynamic var tempMax1: Int = 0
    @objc dynamic var cityName1: String = ""
    @objc dynamic var desc1: String = ""
}




