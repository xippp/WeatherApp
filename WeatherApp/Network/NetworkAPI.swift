//
//  NetworkAPI.swift
//  WeatherApp
//
//  Created by Paul on 3/5/2567 BE.
//

import Foundation

enum NetworkStatusError: Error {
    case urlError
    case cannotParseData
    case unexpectedError
}

enum NetworkStatus {
    case success
    case failure(_ err: NetworkStatusError)
}

class NetworkAPI {
    
    func callGetWeatherAPI(completionHandle: @escaping(_ result: Result<WeatherModel, NetworkStatusError>) -> Void) {
        
        let url = "https://api.open-meteo.com/v1/forecast?latitude=15.5&longitude=101&current=temperature_2m&hourly=temperature_2m&daily=temperature_2m_max,temperature_2m_min&timezone=Asia%2FBangkok"
        
        guard let url = URL(string: url) else {
            completionHandle(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, URLResponse, err in
            if err == nil,
               let data = dataResponse {
                do {
                    let resultData = try JSONDecoder().decode(WeatherModel.self, from: data)
                        completionHandle(.success(resultData))
                } catch {
                    print("Error occurred while decoding JSON data: \(error)")
                    completionHandle(.failure(.cannotParseData))
                }
            } else {
                print("Unexpected nil dataResponse")
                completionHandle(.failure(.unexpectedError))
            }
        }.resume()
    }
}
