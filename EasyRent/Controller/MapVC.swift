//
//  MapVC.swift
//  EasyRent
//
//  Created by Hitesh on 2022-11-23.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapVC: UIViewController {
    static let identifier = "MapVC"
    var startPosition:GMSPlace!
    var destinationPosition:GMSPlace!
    
    //MARK: IBOutlets
    @IBOutlet weak var mapView: GMSMapView!
    
    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
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
        getPath()
    }
    fileprivate func getPath(){
        let routeLink = "https://maps.googleapis.com/maps/api/directions/json?origin=\(startPosition.coordinate.latitude),\(startPosition.coordinate.longitude)&destination=\(destinationPosition.coordinate.latitude),\(destinationPosition.coordinate.longitude)&key=\(GOOGLE_API_KEY)"
        Webservices.instance.get(url: routeLink, params: nil) { success, response, error in
            if success {
                guard let routes = (response as AnyObject)["routes"] as? [Any], let route = routes[0] as? [String: Any], let legs = route["legs"] as? [Any], let leg = legs[0] as? [String: Any], let steps = leg["steps"] as? [Any] else {
                    Utility.showAlert(with: .noPath, on: self)
                    return
                }
                self.plotPathInMap(steps)
            } else {
                Utility.showAlert(with: Messages(rawValue: error ?? "Something went wrong") ?? .commonError, on: self)
            }
        }
    }
    fileprivate func plotPathInMap(_ steps:[Any]){
        for item in steps {
            guard let step = item as? [String: Any] else {
                return
            }
            guard let polyline = step["polyline"] as? [String: Any] else {
                return
            }
            guard let polyLineString = polyline["points"] as? String else {
                return
            }
            // method that draws a path on map
            DispatchQueue.main.async {
                self.drawPath(from: polyLineString)
            }
        }
    }
    fileprivate func drawPath(from polyStr: String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 4.0
        polyline.map = mapView
        let cameraUpdate = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: startPosition.coordinate, coordinate: destinationPosition.coordinate))
        mapView.moveCamera(cameraUpdate)
        let currentZoom = mapView.camera.zoom
        mapView.animate(toZoom: currentZoom - 0.6)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.addStartDestinationMarkers()
        })
    }
    fileprivate func addStartDestinationMarkers(){
        let startMarker = GMSMarker()
        startMarker.position = CLLocationCoordinate2D(latitude:startPosition.coordinate.latitude, longitude:startPosition.coordinate.longitude)
        startMarker.title = startPosition.name
        startMarker.snippet = startPosition.formattedAddress
        startMarker.map = self.mapView
        
        let destMarker = GMSMarker()
        destMarker.position = CLLocationCoordinate2D(latitude:destinationPosition.coordinate.latitude, longitude:destinationPosition.coordinate.longitude)
        destMarker.title = destinationPosition.name
        destMarker.snippet = destinationPosition.formattedAddress
        destMarker.map = self.mapView
    }

}
