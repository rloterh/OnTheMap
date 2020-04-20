//
//  FindSpotVC.swift
//  OnTheMap
//
//  Created by Admin on 17/04/2020.
//  Copyright © 2020 com.robert.loterh. All rights reserved.
//

import UIKit
import MapKit

class FindSpotVC: UIViewController {
    
    @IBOutlet weak var spotTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var studentArray: [StudentLocation]!
    var updatePin: Bool!
    var mediaUrl: String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func findLocation(_ sender: Any) {
        guard let location = spotTextField.text else { return }
        if location == "" {
            showAlert(title: "wrong location name", message: "Enter location name to find place on map")
        }else {
            guard let urlText = urlTextField.text else { return }
            guard urlText != "" else {
                showAlert(title: "Empty Media Field", message: "You must provide a url.")
                return
            }
            mediaUrl = urlText.prefix(7).lowercased().contains("http://") || urlText.prefix(8).lowercased().contains("https://") ? urlText : "https://" + urlText
            print(URL(string: mediaUrl)!)
        }
        findLocation(location)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FinishSpot" {
            let controller = segue.destination as! SpotMapVC
            let locationDetails = sender as!  (String, CLLocationCoordinate2D)
            controller.location = locationDetails.0
            controller.coordinate = locationDetails.1
            controller.updatePin = updatePin
            controller.studentLocArray = studentArray
            print("prepare URL: \(mediaUrl)")
            controller.url = mediaUrl
        }
    }
    
    func setGeoCodingStatus(_ geocoding: Bool) {
        geocoding ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func findLocation(_ location: String) {
        self.setGeoCodingStatus(true)
        CLGeocoder().geocodeAddressString(location) { (placemark, error) in
            guard error == nil else {
                self.showAlert(title: "Failed", message: "Can not find spot: \(location)")
                return
            }
            let coordinate = placemark?.first!.location!.coordinate
            print(coordinate?.latitude ?? 0)
            print(coordinate?.longitude ?? 0)
            self.setGeoCodingStatus(false)
            self.performSegue(withIdentifier: "FinishSpot", sender: (location, coordinate))
        }
    }
}
