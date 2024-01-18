//
//  LocationsView.swift
//  ScavengerHunt
//
//  Created by Juman Dhaher on 04/07/1445 AH.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var  vm: LocationsViewModel
    
    var body: some View {
        ZStack{
            
            
           mapLayer.ignoresSafeArea()
            
            VStack{
                header.padding()
                
                Spacer()
                
                locationpreviewStack

            }
            .sheet(item: $vm.sheetLocation, onDismiss: nil){  location in
                LocationDetailView(location: location)
            }
        }
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations, annotationContent: { location in
            // MapMarker(coordinate: location.coordinates)
            MapAnnotation(coordinate: location.coordinates) {
                MapAnnotationLocationView().scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    
    
    private var locationpreviewStack: some View {
        
        ZStack{
            ForEach(vm.locations){
                location in
                if vm.mapLocation == location {
                    LocationsPreviewView(location: location)
                        .shadow(
                            color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}

#Preview {
    LocationsView().environmentObject(LocationsViewModel())
}

extension LocationsView{
    private var header: some View{
        VStack(spacing: 0 ){
            Button(action: vm.toggleLocationList, label: {
                Text(vm.mapLocation.name + " , " + vm.mapLocation.cityName).font(.title2).fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none,value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline).foregroundColor(.primary).padding()
                            .rotationEffect(Angle(degrees: vm.showMapList ? 180 : 0))
                    }
            })
            if(vm.showMapList){
                LocationListView()
            }
            
        }.background(.thinMaterial)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
}
