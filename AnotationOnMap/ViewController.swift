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
    let annotation = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(49.832802, 23.999520)
        let location2: CLLocationCoordinate2D = CLLocationCoordinate2DMake(49.832837, 24.000512)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        
        //let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "MY STAFF"
        annotation.subtitle = "SOMETHING ABOUT IT"
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = location2
        annotation2.title = "MY STAFF2"
        annotation2.subtitle = "SOMETHING ABOUT IT2"
        
        
        
        let annotations: [MKAnnotation] = [annotation, annotation2]
        map.addAnnotations(annotations)
        
    }
    
    //MARK: map delegate methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Reuse"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
        } else {
            annotationView?.annotation = annotation
        }
//        let im = UIImage(named: "launching1.jpg")!
//        annotationView?.image = im
        return annotationView
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        // if view.annotation?.coordinate == someCoordinateThatWeNeed {}
        
        
        let rect = CGRect(x: 0, y: 0, width: 59, height: 59)
        let iView = UIImageView(frame: rect)
        iView.image = UIImage(named: "14315211077656.jpg")
        view.leftCalloutAccessoryView = iView
        
        let im = #imageLiteral(resourceName: "plus-minus-01-512")
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.setImage(im, for: .normal)
        
        view.rightCalloutAccessoryView = btn

        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        control.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            control.transform = CGAffineTransform.identity
        }, completion: nil)
            
            var annotationDeselected = false
            
            for selectedAnotation in arrayOfSelectedAnnotations {
                
                if selectedAnotation.title! == view.annotation?.title! {
                    (view as! MKPinAnnotationView).pinTintColor = UIColor.red
                    
                    for i in 0..<arrayOfSelectedAnnotations.count {
                        if arrayOfSelectedAnnotations[i].title! == selectedAnotation.title! {
                            arrayOfSelectedAnnotations.remove(at: i)
                            break;
                        }
                    }
                    annotationDeselected = true
                }
            }
            if !annotationDeselected {
                (view as! MKPinAnnotationView).pinTintColor = UIColor.black
                arrayOfSelectedAnnotations.append(view.annotation!)
            }
        
    }
    
}

