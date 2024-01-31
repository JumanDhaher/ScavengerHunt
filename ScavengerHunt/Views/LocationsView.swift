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
        ZStack(alignment: .bottom){
            
            mapLayer.ignoresSafeArea()
            
            VStack{
                
                ZStack{
                    header.padding()
                }
                
                Spacer()
                
                //locationpreviewStack
                
               // floatingSearchButton
            

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
                            vm.sheetLocation = location
                            vm.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var changeThemeFrog: some View{
        ZStack(alignment: .center)
            {
                Rectangle()
                    .fill(Color("buttonColor"))
                    .frame(width: 45, height: 45)        .cornerRadius(3.0)
                
                
                Image("orangeFrog")
                    .resizable()
                    .scaledToFit()
                    . font (. headline)
                    .border(.accent, width: 3)
                    .background(.white)
                    . frame (width: 40,height: 40)        .cornerRadius(3.0)
            }
    }
    
    
    private var floatingSearchButton: some View{
        Button(action: {
            vm.toggleShowLocationBar()
        }, label: {
            HStack{
                Spacer()
                Image(systemName: vm.showLocationBar ? "xmark" : "magnifyingglass")
                    .frame(width: 20, height: 20)
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(.gray)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4, x: 0, y: 4)
            }
        }).padding(.horizontal, 20)
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
                HStack{
                    changeThemeFrog

                    Button(action: vm.toggleLocationList, label: {
                        HStack{
                            Text(vm.mapLocation.name + " , " + vm.mapLocation.cityName).font(.title3).fontWeight(.black)
                                .foregroundColor(.primary)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .animation(.none,value: vm.mapLocation)
                                .overlay(alignment: .leading) {
                                    Image(systemName: "arrow.down")
                                        .font(.headline).foregroundColor(.primary).padding()
                                        .rotationEffect(Angle(degrees: vm.showMapList ? 180 : 0))
                                }
                        }.background(.thinMaterial)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
                    })
                }
                if(vm.showMapList){
                    LocationListView()
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
                }
                
            }
    }
}
