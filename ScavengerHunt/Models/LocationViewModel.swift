//
//  LocationViewModel.swift
//  ScavengerHunt
//
//  Created by Juman Dhaher on 05/07/1445 AH.
//

import SwiftUI
import MapKit

class LocationsViewModel: ObservableObject{
    
    @Published var locations: [Location]
    
    //currrent location
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }

    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //show list
    @Published var showMapList: Bool = false

    @Published var sheetLocation: Location? = nil

    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location){
        
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates, span: mapSpan)
        }
    }
    
     func toggleLocationList(){
        withAnimation(.easeInOut){
           showMapList = !showMapList
        }
    }
    
    func showNextLocation(location: Location){
       withAnimation(.easeInOut){
          mapLocation = location
          showMapList = false
       }
   }
    
    func nexyButtonPressed(){
       guard let currentIndex = locations.firstIndex(where: {
            $0 == mapLocation
       }) else{
           print("Not find ")
           return
       }
        
        let nextIndex = currentIndex + 1
        
        guard locations.indices.contains(nextIndex) else {
            //next index not valled and wee well return
            guard  let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
   }
    
}

