//
//  FlightTrackerViewController.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import UIKit


protocol FlightTrackerViewControllerInterface {
    func setStationData(stations: [StationModel]?)
    func setFlightData(flights: [FlightModel]?)
    func showError(error: String)
}

class FlightTrackerViewController: UIViewController {
    
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var departureDateTextField: UITextField!
    @IBOutlet weak var returnDateTextField: UITextField!
    @IBOutlet weak var adultsTextField: UITextField!
    @IBOutlet weak var teensTextField: UITextField!
    @IBOutlet weak var childrenTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var roundTripButton: UIButton!
    @IBOutlet weak var flightsTableView: UITableView!
    
    var pickerView = UIPickerView()
    var datePickerView = UIDatePicker()
    
    var stations: [StationModel]?
    var destinationArray: [StationModel]?
    var flights: [FlightModel]?
    var originStation: StationModel?
    var searchFlightModel: SearchFlightModel?
    
    var textFieldTag = 0
    
    let presenter: FlightTrackerPresenterInterface?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(nibName: String, bundle: Bundle?, presenter: FlightTrackerPresenterInterface?) {
        self.presenter = presenter != nil ? presenter : nil
        super.init(nibName: nibName, bundle: bundle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        searchFlightModel = SearchFlightModel()
        self.configureView()
    }
    
    func configureView() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.originTextField.inputView = pickerView
        self.destinationTextField.inputView = pickerView
        self.adultsTextField.inputView = pickerView
        self.teensTextField.inputView = pickerView
        self.childrenTextField.inputView = pickerView
        
        self.datePickerView.datePickerMode = .date
        self.datePickerView.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        self.departureDateTextField.inputView = datePickerView
        
        self.returnDateTextField.inputView = datePickerView
        self.highlightRoundtripButton(isHighlighted: searchFlightModel?.roundTrip ?? false)
    }
    
    func filterDestinations(markets: [MarketsNetworkOutput]) -> [StationModel]{
        var destinationArray: [StationModel] = []
        for market in markets {
            if let currentStations = stations {
                for station in currentStations {
                    if station.code == market.code {
                        destinationArray.append(station)
                    }
                }
            }
        }
        return destinationArray
        
    }
    
    func highlightRoundtripButton(isHighlighted: Bool) {
        self.roundTripButton.alpha = isHighlighted ? 1: 0.2
    }
    
    
    @IBAction func roundTripClicked(_ sender: Any) {
        if let roundtrip = self.searchFlightModel?.roundTrip {
            self.searchFlightModel?.roundTrip = !roundtrip
            self.highlightRoundtripButton(isHighlighted: !roundtrip)
        }
    }
    @IBAction func searchButtonClicked(_ sender: Any) {
        if let searchFlight = self.searchFlightModel {
            self.presenter?.seachFlights(searchFlightModel: searchFlight)
        }
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        
        let format = "yyy-MM-dd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        switch textFieldTag {
        case 2:
            self.searchFlightModel?.departureDate = "\(dateFormatter.string(from: sender.date))"
            self.departureDateTextField.text = self.searchFlightModel?.departureDate
            
        case 3:
            self.searchFlightModel?.returnDate = "\(dateFormatter.string(from: sender.date))"
            
            self.returnDateTextField.text = self.searchFlightModel?.returnDate
        default:
            print("default")
        }
    }
}

extension FlightTrackerViewController: FlightTrackerViewControllerInterface{
    func showError(error: String) {
        print("error \(error)")
    }
    
    func setFlightData(flights: [FlightModel]?) {
        self.flights = flights
        self.flightsTableView.reloadData()
    }
    
    func setStationData(stations: [StationModel]?) {
        self.stations = stations
        self.configureView()
    }
}

extension FlightTrackerViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textFieldTag = textField.tag
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        self.pickerView.reloadAllComponents()
    }
}

extension FlightTrackerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.textFieldTag {
        case 0:
            return self.stations?.count ?? 0
        case 1:
            return self.destinationArray?.count ?? 0
        case 4:
            return 5
        case 5,6:
            return 6
        default:
            return self.stations?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch self.textFieldTag {
        case 0:
            return "\(self.stations?[row].countryName ?? "") - \(self.stations?[row].countryCode ?? "")"
        case 1:
            return "\(self.destinationArray?[row].countryName ?? "") - \(self.destinationArray?[row].countryCode ?? "")"
            
        case 4:
            return "\(row + 1)"
        case 5, 6:
            return "\(row)"
        default:
            return self.stations?[row].countryName
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch self.textFieldTag {
        case 0:
            self.originStation = stations?[row]
            self.originTextField.text = "\(originStation?.countryName ?? "") - \(originStation?.countryCode ?? "")"
            if let markets = self.originStation?.markets {
                self.destinationArray = self.filterDestinations(markets: markets )
            }
            self.searchFlightModel?.origin = originStation?.countryCode
            self.searchFlightModel?.originCode = originStation?.code
            
            
        case 1:
            
            let destinationStation = self.destinationArray?[row]
            self.searchFlightModel?.destination = destinationStation?.countryCode
            self.searchFlightModel?.destinationCode = destinationStation?.code
            
            self.destinationTextField.text = "\(destinationStation?.countryName ?? "") - \(destinationStation?.countryCode ?? "")"
            
        case 4:
            self.searchFlightModel?.adults = row + 1
            self.adultsTextField.text = "\(self.searchFlightModel?.adults ?? 1)"
        case 5:
            self.searchFlightModel?.teens = row
            self.teensTextField.text = "\(self.searchFlightModel?.teens ?? 0)"
            
        case 6:
            self.searchFlightModel?.children = row
            self.childrenTextField.text = "\(self.searchFlightModel?.children ?? 0)"
            self.childrenTextField.endEditing(true)
            
        default:
            print("default")
        }
        
    }
}

extension FlightTrackerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = "date: \(flights?[indexPath.row].date ?? ""). FlightNumber: \(flights?[indexPath.row].flightNumber ?? ""). Regular Fare: \(flights?[indexPath.row].totalFare ?? 0)"
        cell.textLabel?.font = UIFont(name:"Avenir", size:10)
        
        return cell

    }
    
    
}
