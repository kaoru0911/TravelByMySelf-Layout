//
//  ViewController.swift
//  travelToMySelfLayOut
//
//  Created by 倪僑德 on 2017/4/5.
//  Copyright © 2017年 Chiao. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var spotTableView: UITableView!
    @IBOutlet weak var spotSearchTextField: UITextField!
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    // TableView陣列
    var ListArray: NSMutableArray = []
    
    var placesClient: GMSPlacesClient!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        placesClient = GMSPlacesClient.shared()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "viewPointTableViewCell")
        
        cell.textLabel?.text = "\(ListArray.object(at: indexPath.row))"
        return cell
    }
    
    @IBAction func addSpotBtn(_ sender: Any) {
        // 加入搜尋列的輸入名稱
        guard spotSearchTextField.text != "" else {
            return
        }
        let SpotSearchChar:String = spotSearchTextField.text!
        // 欄位編號
        let SpotSearchNumber = String(ListArray.count+1)
        ListArray.add("No"+SpotSearchNumber+"."+SpotSearchChar)
        self.spotTableView.reloadData();
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        let center = CLLocationCoordinate2D(latitude: 37.788204, longitude: -122.411937)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePicker(config: config)
        
        placePicker.pickPlace(callback: {(place, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            //            if let place = place {
            //                self.nameLabel.text = place.name
            //                self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
            //                    .joined(separator: "\n")
            //            } else {
            //                self.nameLabel.text = "No place selected"
            //                self.addressLabel.text = ""
            //            }
        })
    }
}


