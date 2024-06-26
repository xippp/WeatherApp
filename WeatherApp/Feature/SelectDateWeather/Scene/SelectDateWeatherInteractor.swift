//
//  SelectDateWeatherInteractor.swift
//  WeatherApp
//
//  Created by Paul on 3/5/2567 BE.
//  Copyright (c) 2567 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SelectDateWeatherBusinessLogic
{
    func getDataToDisplay(request: SelectDateWeather.GetDataToDisplay.Request)
}

protocol SelectDateWeatherDataStore
{
    var titleDate: String { get set }
    var timeArray: [String] { get set }
    var tempArray: [String] { get set }
    var tempUnit: String { get set }
}

class SelectDateWeatherInteractor: SelectDateWeatherBusinessLogic, SelectDateWeatherDataStore
{
    var titleDate: String = ""
    
    var timeArray: [String] = []
    
    var tempArray: [String] = []
    
    var tempUnit: String = ""
    
  var presenter: SelectDateWeatherPresentationLogic?
  var worker: SelectDateWeatherWorker?
  //var name: String = ""
  
  // MARK: Do something
  
    func getDataToDisplay(request: SelectDateWeather.GetDataToDisplay.Request) {
        let dataDisplay = DisplayWeatherTimeModel(titleDate: self.titleDate,
                                                  timeArray: self.timeArray,
                                                  tempArray: self.tempArray,
                                                  tempUnit: self.tempUnit)
        let response = SelectDateWeather.GetDataToDisplay.Response(dataDisplay: dataDisplay)
        presenter?.presentGetDataToDisplay(response: response)
    }
    
}
