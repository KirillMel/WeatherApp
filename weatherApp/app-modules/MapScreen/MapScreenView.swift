//
//  MapScreenView.swift
//  weatherApp
//
//  Created by kirill on 3/18/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import UIKit
import MapKit

class MapScreenViewController: UIViewController, MapScreenViewProtocol, TransitionHandlerProtocol {
    //MARK: - Viper layers
    let configurator: MapScreenConfiguratorProtocol = MapScreenConfigurator()
    var presenter: MapScreenPresenterToViewProtocol?
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Constants
    let regionInMeters: Double = 10000
    let heighFovoriteButton: Int = 35
    let widthFavoriteButton: Int = 35
    
    //MARK: - Variables
    private var isAdded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter?.setUpModule()
        setUpUI()
    }
    
    //MARK: - implementation MapScreenViewProtocol
    func addAnnotation(title: String, subtitle: String, altitude: Double, longitude: Double) {
        isAdded = false
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: altitude, longitude: longitude)
        annotation.title = title
        annotation.subtitle = subtitle
        self.mapView.addAnnotation(annotation)
    }
    
    func displayAnnotation() {
        
    }
    
    func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            break
        case .denied:
            showAlert(title: "Notice", message: "You have danied the access status.")
            break
        case .notDetermined:
            CLLocationManager().requestWhenInUseAuthorization()
        case .restricted:
            showAlert(title: "Notice", message: "You have restricted the status")
            break
        case .authorizedAlways:
            break
        }
    }
    
    //MARK: - private helper methods
    private func setUpUI() {
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTapOnMap))
        mapView.addGestureRecognizer(longTapGesture)
    }
    
    private func deleteAnnotations() {
        if (mapView.annotations.count > 0) {
            let allAnnotations = mapView.annotations
            mapView.removeAnnotations(allAnnotations)
        }
    }
    
    private func centerViewOnUserLocation(_ location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    //MARK: - Gestures
    @objc func longTapOnMap(sender: UIGestureRecognizer) {
        if sender.state == .began {
            deleteAnnotations()
            
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            
            presenter?.locationDidSelected(altitude: locationOnMap.latitude, longitude: locationOnMap.longitude)
            
            centerViewOnUserLocation(locationOnMap)
        }
    }
}

extension MapScreenViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            
            pinView!.rightCalloutAccessoryView = UIButton(frame: CGRect(x: 0, y: 0, width: widthFavoriteButton, height: heighFovoriteButton))
            pinView!.pinTintColor = UIColor.black
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //set image on button
        let button = view.rightCalloutAccessoryView as? UIButton
        if (isAdded) {
            button?.setImage(UIImage(named: "favorite_black.png"), for: .normal)
        } else {
            button?.setImage(UIImage(named: "favorite_white.png"), for: .normal)
        }
    }
    
    //MARK: - add to favorites
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let button = view.rightCalloutAccessoryView as? UIButton
        
        if control == view.rightCalloutAccessoryView {
            if view.annotation?.title != nil {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: { button?.alpha = 0 }, completion:
                    { _ in
                        if (!self.isAdded) {
                            DispatchQueue.main.async {
                                button?.setImage(UIImage(named: "favorite_black.png"), for: .normal)
                            }
                            self.presenter?.addCurrentLocationToFavorites()
                        } else {
                            DispatchQueue.main.async {
                                button?.setImage(UIImage(named: "favorite_white.png"), for: .normal)
                            }
                            self.presenter?.removeCurrentLocationFromFavorites()
                        }
                        self.isAdded = !self.isAdded
                    
                        UIView.animate(withDuration: 0.25, animations: {
                            button?.alpha = 1
                        })
                    })
            }
        }
    }
}
