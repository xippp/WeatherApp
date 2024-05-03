//
//  SelectDateWeatherViewController.swift
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


class SelectDateWeatherViewController: UIViewController
{
  var interactor: SelectDateWeatherBusinessLogic?
  var router: (NSObjectProtocol & SelectDateWeatherRoutingLogic & SelectDateWeatherDataPassing)?
    var dataDispaly: DisplayWeatherTimeModel?
//    MARK: -IBOutlet Property
    
    @IBOutlet weak var titleDateLabel: UILabel!
    
    @IBOutlet weak var backButtonView: UIButton! {
        didSet {
            backButtonView.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var timeWeatherTableView: UITableView! {
        didSet {
            timeWeatherTableView.dataSource = self
            timeWeatherTableView.delegate = self
            timeWeatherTableView.register(UINib(nibName: "ShowDailyWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyWeatherCell")
        }
    }
    
//    MARK: -IBAction
    
    
    @IBAction func backViewAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    let interactor = SelectDateWeatherInteractor()
    let presenter = SelectDateWeatherPresenter()
    let router = SelectDateWeatherRouter()
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
    getDataToDisplay()
  }
  

    func getDataToDisplay() {
        let request = SelectDateWeather.GetDataToDisplay.Request()
        interactor?.getDataToDisplay(request: request)
    }

}

protocol SelectDateWeatherDisplayLogic: class
{
    func displayGetDataToDisplay(viewModel: SelectDateWeather.GetDataToDisplay.ViewModel)
}


extension SelectDateWeatherViewController: SelectDateWeatherDisplayLogic {

    func displayGetDataToDisplay(viewModel: SelectDateWeather.GetDataToDisplay.ViewModel) {
        self.dataDispaly = viewModel.dataDisplay
        titleDateLabel.text = viewModel.dataDisplay.titleDate
        timeWeatherTableView.reloadData()
    }
}

//MARK: -TableView DataSource and Delegate

extension SelectDateWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataDispaly?.timeArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell", for: indexPath) as? ShowDailyWeatherTableViewCell else { return UITableViewCell() }
        cell.firstLabel.text = self.dataDispaly?.timeArray[indexPath.row]
        cell.midLabel.isHidden = true
        cell.lastLabel.text = self.dataDispaly?.tempArray[indexPath.row]
        return cell
    }
    
    
}
