//
//  MainpageViewController.swift
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

class MainpageViewController: UIViewController
{
  var interactor: MainpageBusinessLogic?
  var router: (NSObjectProtocol & MainpageRoutingLogic & MainpageDataPassing)?
    var countTemp = 0
    var minTemp: [String] = []
    var maxTemp: [String] = []
    var unitTemp = ""
    var dateName: [String] = []
    var date: [String] = []
//    MARK: -IBOutlet Property
    
    
    @IBOutlet weak var temTitleLabel: UILabel!
    
    
    @IBOutlet weak var weatherTableView: UITableView! {
        didSet {
            weatherTableView.register(UINib(nibName: "ShowDailyWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyWeatherCell")
            weatherTableView.delegate = self
            weatherTableView.dataSource = self

        }
    }
    
    @IBOutlet weak var titleButton: UIButton! {
        didSet {
            titleButton.setTitle("", for: .normal)
        }
    }
    
//    MARK: -IBAction
    
    
    @IBAction func SelectTitleDate(_ sender: Any) {
        self.selectWeatherDate(index: 0)
    }
    
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = MainpageInteractor()
    let presenter = MainpagePresenter()
    let router = MainpageRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
      self.navigationController?.isNavigationBarHidden = true
    fetchWeather()
  }
  
    func fetchWeather() {
        let request = Mainpage.FetchWeatherModel.Request()
        interactor?.fetchWeather(request: request)
    }
    
    func getWeatherDaily() {
        let request = Mainpage.GetWeatherDaily.Request()
        interactor?.getWeatherDaily(request: request)
    }
    
    func selectWeatherDate(index: Int) {
        let request = Mainpage.SelectWeatherDate.Request(index: index)
        interactor?.selectWeatherDate(request: request)
    }
  
}

protocol MainpageDisplayLogic: class
{
    func displayFetchedWeather(viewModel: Mainpage.FetchWeatherModel.ViewModel)
    func displayGetWeatherDaily(viewModel: Mainpage.GetWeatherDaily.ViewModel)
    func displaySelectWeatherDate(viewModel: Mainpage.SelectWeatherDate.ViewModel)
    
}

extension MainpageViewController: MainpageDisplayLogic {
    
    func displayFetchedWeather(viewModel: Mainpage.FetchWeatherModel.ViewModel) {
        switch viewModel.status {
        case .success:
            self.getWeatherDaily()
        case .failure(let err):
            switch err {
            case .urlError:
                print("URL Error")
            case .cannotParseData:
                print("Cannot Parse Data")
            case .unexpectedError:
                print("Unexpect Error")
            }
        }
    }
    
    func displayGetWeatherDaily(viewModel: Mainpage.GetWeatherDaily.ViewModel) {
        self.countTemp = viewModel.maxTemp.count
        self.minTemp = viewModel.minTemp
        self.maxTemp = viewModel.maxTemp
        self.unitTemp = viewModel.unitTemp
        self.dateName = viewModel.dateName
        self.date = viewModel.shortDate
        DispatchQueue.main.async {
            self.temTitleLabel.text = "\(viewModel.minTemp[0])\(viewModel.unitTemp)/\(viewModel.maxTemp[0])\(viewModel.unitTemp)"
            self.weatherTableView.reloadData()
        }
    }
    
    func displaySelectWeatherDate(viewModel: Mainpage.SelectWeatherDate.ViewModel) {
        self.router?.routeToSelectDateWeather()
    }
    
}

//MARK: -DataSource and Delegate TableView

extension MainpageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countTemp
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell", for: indexPath) as? ShowDailyWeatherTableViewCell else { return UITableViewCell() }
        cell.firstLabel.text = self.date[indexPath.row]
        cell.midLabel.text = self.dateName[indexPath.row]
        cell.lastLabel.text = "\(self.minTemp[indexPath.row])\(self.unitTemp)/\(self.maxTemp[indexPath.row])\(self.unitTemp)"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectWeatherDate(index: indexPath.row)
    }
    
}
