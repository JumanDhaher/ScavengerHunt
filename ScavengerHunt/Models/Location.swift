//
//  Location.swift
//  ScavengerHunt
//
//  Created by Juman Dhaher on 04/07/1445 AH.
//

import Foundation
import MapKit

struct Location : Identifiable , Equatable{
   
    let name: String
    let cityName: String
    let coordinates:  CLLocationCoordinate2D
    let description: String
    let  imageNames: [String]
    let link: String
    
    //Identifiable
    var id: String {
        name + cityName
    }
    
    //Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
