//
//  AirQualityController.swift
//  AirQualityAPI
//
//  Created by lijia xu on 8/5/21.
//

import Foundation


enum NetworkError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server "
        case .thrownError(let err):
            return "Error: \(err.localizedDescription) -- \(err) "
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "There was an error trying to decode data"
        }
        
    }//End Of errDescription
    
    
}//End Of Network Error

class AirQualityController {
    static let baseURL = URL(string: "http://api.airvisual.com/")
    static let versionComponent = "v2"
    static let countriesComponent = "countries"
    static let statesComponent = "states"
    static let citiesComponent = "cities"
    
    static let countryKey = "country"
    static let stateKey = "state"
    
    static let apiKeyHashKey = "key"
    static let apiKeyValue = "cf0dda60-0b1b-4768-bbf1-a0e4e532e933"
    
    //http://api.airvisual.com/v2/countries?key={{YOUR_API_KEY}}
    static func fetchCountries(completion: @escaping (Result<[String],NetworkError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let versionURL = baseURL.appendingPathComponent(versionComponent)
        let countriesURL = versionURL.appendingPathComponent(countriesComponent)
        
        var components = URLComponents(url: countriesURL, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: apiKeyHashKey, value: apiKeyValue)
        components?.queryItems = [apiQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(Country.self, from: data)
                let countries = topLevelObject.data
                
                let listOfCountryNames = countries.reduce(into: [String]()) { $0 = $0 + [$1.countryName] }
                
                return completion(.success(listOfCountryNames))
                
            } catch {
                return completion(.failure(.unableToDecode))
            }
        
            
        }
        
    }//End Of fetch countries
    
    //http://api.airvisual.com/v2/states?country={{COUNTRY_NAME}}&key={{YOUR_API_KEY}}
    static func fetchStates() {
        
    }
    //http://api.airvisual.com/v2/cities?state={{STATE_NAME}}&country={{COUNTRY_NAME}}&key={{YOUR_API_KEY}}
    static func fetchCities() {
        
    }
    //http://api.airvisual.com/v2/city?city=Los Angeles&state=California&country=USA&key={{YOUR_API_KEY}}
    static func fetchData() {
        
    }
    
    
}

