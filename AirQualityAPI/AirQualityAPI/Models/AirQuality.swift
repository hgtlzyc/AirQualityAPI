//
//  AirQuality.swift
//  AirQualityAPI
//
//  Created by lijia xu on 8/5/21.
//

import Foundation


struct Country: Codable {
    
    let data: [CountryData]

    
    struct CountryData: Codable {
        let countryName: String
        
        enum CodingKeys: String, CodingKey {
            case countryName = "country"
        }
    }

}//End Of Country 

struct State: Codable {
    
    let data: [StateData]
    
    struct StateData: Codable {
        let stateName: String
        
        enum CodingKeys: String, CodingKey {
            case stateName = "state"
        }
    }
    
}//End Of State

struct City: Codable {
    
    let data: [CityData]
    
    struct CityData: Codable {
        let cityName: String
        
        enum CodingKeys: String, CodingKey {
            case cityName = "city"
        }
    }
    
}//End Of City


struct CityInfo: Codable {
    let data : CityInfoData
    
    struct CityInfoData: Codable {
        let city: String
        let state: String
        let country: String
        
        let location: Location
        struct Location: Codable {
            let coordinate: [Double]
        }
        
        let current: Current
        struct Current: Codable {
            let weather: Weather
            struct Weather: Codable{
                let tp: Int
                let hu: Int
                let ws: Double
            }
            
            let pollution: Pollution
            struct Pollution: Codable {
                let aqius: Int
            }
        }
        
    }//End Of CityInfoData

}//End Of CityInfo

