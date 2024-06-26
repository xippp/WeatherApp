//
//  SelectDateWeatherPresenter.swift
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

protocol SelectDateWeatherPresentationLogic
{
    func presentGetDataToDisplay(response: SelectDateWeather.GetDataToDisplay.Response)
}

class SelectDateWeatherPresenter: SelectDateWeatherPresentationLogic
{
  weak var viewController: SelectDateWeatherDisplayLogic?
  
  // MARK: Do something
  
    func presentGetDataToDisplay(response: SelectDateWeather.GetDataToDisplay.Response) {
        let viewModel = SelectDateWeather.GetDataToDisplay.ViewModel(dataDisplay: response.dataDisplay)
        viewController?.displayGetDataToDisplay(viewModel: viewModel)
    }
}
