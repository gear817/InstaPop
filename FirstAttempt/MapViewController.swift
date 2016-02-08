//
//  MapViewController.swift
//  FirstAttempt
//
//  Created by Danny Vasquez on 2/4/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Photos


class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let resultCollections = PHAssetCollection.fetchAssetCollectionsWithType(.Moment, subtype: .Any, options: nil)
        
        resultCollections.enumerateObjectsUsingBlock({
            (object, index, stop) -> Void in
            
            
            let collection = object as! PHAssetCollection
            
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.MediumStyle
            formatter.timeStyle = .ShortStyle
            
            
            var date =  collection.startDate
            var location = collection.approximateLocation?.coordinate
            
            
            func dropPinForLocation(address: StopInfo) {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(address.latitude, address.longitude)
                annotation.title = address.stopName
                annotation.subtitle = "\(location)"
                //  self.mapView.addAnnotation(annotation)
                //   self.annotations.append(annotation)
                self.mapView.addAnnotation(annotation)
    
        
        
        
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    

}
