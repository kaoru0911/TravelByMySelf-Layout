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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    
    
    @IBOutlet weak var spotTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var spotTableView: UITableView!
    
    var placeIdStorage:String!
    
    
    // 用placeID取得google第一張地點照片，並呼叫loadImageForMetadata
    func loadFirstPhotoForPlace(placeID: String) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: self.placeIdStorage) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(photoMetadata: firstPhoto)
                }
            }
        }
    }

    
    
    // 選取要從陣列載入的相片，並放在imageView
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                self.imageView.image = photo;
                //self.attributionTextView.attributedText = photoMetadata.attributions;
            }
        })
    }
    
    // TableView陣列
    var ListArray: NSMutableArray = []
    var placesClient: GMSPlacesClient!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        placesClient = GMSPlacesClient.shared()
        
//        let placeID = "ChIJV4k8_9UodTERU5KXbkYpSYs"
//        placesClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
//            if let error = error {
//                print("lookup place id query error: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let place = place else {
//                print("No place details for \(placeID)")
//                return
//            }
//            
//            
//            
//            print("Place name \(place.name)")
//            print("Place address \(place.formattedAddress)")
//            print("Place placeID \(place.placeID)")
//            print("Place attributions \(place.attributions)")
//        })
        
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
        guard spotTextView.text != "" else {
            return
        }
        let SpotSearchChar:String = spotTextView.text!
        // 欄位編號
        let SpotSearchNumber = String(ListArray.count+1)
        ListArray.add("No"+SpotSearchNumber+"."+SpotSearchChar)
        self.spotTableView.reloadData();
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePicker(config: config)
        
        placePicker.pickPlace(callback: { (place, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place selected")
                return
            }
            self.spotTextView.text = place.name
            self.placeIdStorage = place.placeID
            
            if(self.placeIdStorage != nil){
                self.loadFirstPhotoForPlace(placeID: self.placeIdStorage)
            } else {
                //..
            }
            
            print("Place name \(place.name)")
            print("Place address \(place.formattedAddress)")
            print("Place attributions \(place.attributions)")
            
            print("Place PlaceID \(place.placeID)")
            
        })
        
    }
}


