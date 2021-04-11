//
//  ViewController.swift
//  ValentinaDerksen_Weather
//
//  Created by Valya Derksen on 2021-04-10.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet var pkrCity : UIPickerView!
    @IBOutlet var lblFeelsLike : UILabel!
    @IBOutlet var lblWindSpeed : UILabel!
    @IBOutlet var lblWindDirection : UILabel!
    @IBOutlet var lblUVIndex : UILabel!
    @IBOutlet var lblTemp : UILabel!
    @IBOutlet var lblHeader : UILabel!
    
    
    // an array of items to display in picker view
    let cities = ["", "Toronto", "Moscow", "Tokio", "Delhi", "London"]
    
    private let weatherFetcher = WeatherFetcher.getInstance()
    private var weatherInfo : Weather = Weather()
    

    private var cancellables: Set<AnyCancellable> = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up a picker view to display an array of coffee types
        self.pkrCity.dataSource = self
        self.pkrCity.delegate = self
        
        self.lblTemp.text = "\(self.weatherInfo.temp) °C"
        self.lblFeelsLike.text = "\(self.weatherInfo.feelsLike) °C"
        self.lblWindSpeed.text = "\(self.weatherInfo.windSpeed) km/hr"
        self.lblWindDirection.text = "\(self.weatherInfo.windDirection)"
        self.lblUVIndex.text = "\(self.weatherInfo.uvIndex)"
    }
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(#function, "Selected City: \(self.cities[row])")
        var apiURL = ""
        var selectedCity = ""
        switch row {
        case 1: // Toronto
            apiURL = "https://api.weatherapi.com/v1/current.json?key=50b73bd9ca124ebebe501613211104&q=Toronto&aqi=no"
            selectedCity = "in Toronto"

        case 2: // Moscow
            apiURL = "https://api.weatherapi.com/v1/current.json?key=50b73bd9ca124ebebe501613211104&q=Moscow&aqi=no"
            selectedCity = "in Moscow"

        case 3: // Tokio
            apiURL = "https://api.weatherapi.com/v1/current.json?key=50b73bd9ca124ebebe501613211104&q=Tokio&aqi=no"
            selectedCity = "in Tokio"

        case 4: // Delhi
            apiURL = "https://api.weatherapi.com/v1/current.json?key=50b73bd9ca124ebebe501613211104&q=Delhi&aqi=no"
            selectedCity = "in Delhi"
            
        case 5: // London
            apiURL = "https://api.weatherapi.com/v1/current.json?key=50b73bd9ca124ebebe501613211104&q=London&aqi=no"
            selectedCity = "in London"
        default:
            apiURL = ""
            self.lblHeader.text = "The Current Weather:"
            self.lblTemp.text = "0 °C"
            self.lblFeelsLike.text = "0 °C"
            self.lblWindSpeed.text = "0 km/hr"
            self.lblWindDirection.text = "N/A"
            self.lblUVIndex.text = "0"
            self.viewDidLoad()
        }
        self.lblHeader.text = "The Current Weather \(selectedCity):"
        self.weatherFetcher.fetchDataFromAPI(apiURL: apiURL)
        self.receiveChanges()
    }
    
    private func receiveChanges(){
        self.weatherFetcher.$weatherInfo.receive(on: RunLoop.main)
            .sink { (launch) in
                print(#function, "Received weather info: ", launch)
                self.weatherInfo = launch
                self.viewDidLoad()
            }
            .store(in : &cancellables)
    }
}

