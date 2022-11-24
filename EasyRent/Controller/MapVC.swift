//
//  MapVC.swift
//  EasyRent
//
//  Created by Hitesh on 2022-11-23.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController {
    static let identifier = "MapVC"

    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: Fxns
    fileprivate func setupUI(){
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Map"
    }
    
    fileprivate func setupMap(){
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 43.76194, longitude: -79.41028, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
    
    }
    


}
