//
//  LocationDetailView.swift
//  ScavengerHunt
//
//  Created by Juman Dhaher on 06/07/1445 AH.
//

import SwiftUI
import MapKit
struct LocationDetailView: View {
    
    let location: Location
    @EnvironmentObject private var  vm: LocationsViewModel

    var body: some View {
        ScrollView{
            VStack{
                imageSection.shadow(color: Color.black.opacity(0.3), radius: 20,x: 0,y:10)
                
                VStack(alignment: .leading, spacing: 16.0){
                    titleSection
                    Divider()
                    descrptionSection
                    Divider()
                    mapLayer
                    
                }.frame(maxWidth: .infinity, alignment: .leading).padding()
            }
        }.ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton ,alignment: .topLeading)
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!).environmentObject(LocationsViewModel())
}

extension LocationDetailView{
    private var imageSection: some View{
        TabView{
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 400)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View{
        
        VStack(alignment: .leading, spacing: 8){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title)
                .foregroundColor(.secondary)
        }
    }
    
    private var descrptionSection: some View{
        
        VStack(alignment: .leading, spacing: 16){
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let url = URL(string: location.link){
                Link("Read more on Wikipedia ",destination: url)
                    .font(.headline)
                    .tint(.blue)

            }
        }
    }
    
    private var backButton: some View{
        Button(action: {
            vm.sheetLocation = nil
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        })
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(
            MKCoordinateRegion(
                center:location.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems:[ location ]){ location in
            MapAnnotation(coordinate: location.coordinates) {
                MapAnnotationLocationView()
                    .shadow(radius: 10)
                  
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)

    }
}
