// Student ID: 153803184
// Student name: Valentina Derksen
// https://github.com/vderksen/iOS_WeatherApp

//  WeatherFetch.swift
//  ValentinaDerksen_Weather
//
//  Created by Valya Derksen on 2021-04-10.
//

import Foundation

class WeatherFetcher: ObservableObject{
    
    @Published var weatherInfo = Weather()
    
    //singleton instance
    private static var shared : WeatherFetcher?
    
    static func getInstance() -> WeatherFetcher{
        if shared != nil{
            //instance already exists
            return shared!
        }else{
            // create a new singlton instance
            return WeatherFetcher()
        }
    }
    
    func fetchDataFromAPI(apiURL : String){
        guard let api = URL(string: apiURL) else {
            return
        }
        URLSession.shared.dataTask(with: api){ (data: Data?, response: URLResponse?, error: Error?) in
            if let err = error {
                print(#function, "Could not fetch data", err)
            }else {
                // receive data or response
                
                DispatchQueue.global().async {
                    do {
                        if let jsonData = data {
                            let decoder = JSONDecoder()
                            // use this responce if array of JSON objects
                            let decodedList = try decoder.decode(Weather.self, from: jsonData)
                            // use this responce if JSON object
                            
                            DispatchQueue.main.async {
                                self.weatherInfo = decodedList
                            }
                            
                        } else {
                            print(#function, "No JSON data received")
                        }
                        
                    } catch  let error {
                        print(#function, error)
                    }
                }
            }
        }.resume()
    }
}

