//
//  ViewController.swift
//  AnotationOnMap
//
//  Created by AndreOsip on 7/27/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var arrayOfSelectedAnnotations: [MKAnnotation] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(49.832802, 23.999520)
        let location2: CLLocationCoordinate2D = CLLocationCoordinate2DMake(49.832837, 24.000512)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        
        let anotation = MKPointAnnotation()
        anotation.coordinate = location
        anotation.title = "MY STAFF"
        anotation.subtitle = "SOMETHING ABOUT IT"
        
        let anotation2 = MKPointAnnotation()
        anotation2.coordinate = location2
        anotation2.title = "MY STAFF2"
        anotation2.subtitle = "SOMETHING ABOUT IT2"
        

        
        let anotations: [MKAnnotation] = [anotation, anotation2]
        map.addAnnotations(anotations)

    }
    
    //MARK: map delegate methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let anotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Reuse")
        anotationView.canShowCallout = true
        return anotationView
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        var anotationDisabled = false
        
            for selectedAnotation in arrayOfSelectedAnnotations {
                
                if selectedAnotation.title! == view.annotation?.title! {
                    (view as! MKPinAnnotationView).pinTintColor = UIColor.red
                    
                    for i in 0..<arrayOfSelectedAnnotations.count {
                        if arrayOfSelectedAnnotations[i].title! == selectedAnotation.title! {
                            arrayOfSelectedAnnotations.remove(at: i)
                            break;
                        }
                    }
                    anotationDisabled = true
                }
            }
        if !anotationDisabled {
            (view as! MKPinAnnotationView).pinTintColor = UIColor.black
            arrayOfSelectedAnnotations.append(view.annotation!)
        }

        
        // if view.annotation?.coordinate == someCoordinateThatWeNeed {}
        
        
        let rect = CGRect(x: 0, y: 0, width: 59, height: 59)
        let iView = UIImageView(frame: rect)
        iView.image = UIImage(named: "14315211077656.jpg")
        view.leftCalloutAccessoryView = iView
        
        
        print(map.selectedAnnotations)
        
    }

}

