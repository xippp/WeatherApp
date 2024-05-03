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
  func doSomething(request: SelectDateWeather.Something.Request)
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
  var presenter: SelectDateWeatherPresentationLogic?
  var worker: SelectDateWeatherWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: SelectDateWeather.Something.Request)
  {
    worker = SelectDateWeatherWorker()
    worker?.doSomeWork()
    
    let response = SelectDateWeather.Something.Response()
    presenter?.presentSomething(response: response)
  }
}