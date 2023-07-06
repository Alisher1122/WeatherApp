//
//  Strucs.swift
//  AppLifeCiycle
//
//  Created by Alisher on 01/06/23.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire




struct MainResponse: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [Hourly]
    let city: City
}


struct CurrentWeatherData: Codable {
   
    let coord: Coord
    let weather: [Weather]
    let base:String
    let main: Main
    let visibility: Int?
    let wind: Wind
    let cloudes: Cloudes?
    let dt: Int
    let sys: City
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
}

struct Hourly: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let cloudes: Cloudes?
    let wind: Wind
    let visibility: Int?
    let pop: Double
    let rain: Rain?
    let sys: SYS
    let dt_txt: String
}

struct City: Codable {
   
    let type: Int?
    
    let id: Int
    let name: String?
    let coord: Coord?
    let country: String
    let population: Int?
    let timezone: Int?
    let sunrise: Int
    let sunset: Int

}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int?
    let grnd_level: Int?
    let humidity: Int
    let temp_kf: Double?

}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Cloudes: Codable {
    let all: Int
}


struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}


struct Rain: Codable {
    let Threeh: Double?
}

struct SYS: Codable {
    let pod: String
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}

