//
//  LocationsPreviewView.swift
//  ScavengerHunt
//
//  Created by Juman Dhaher on 05/07/1445 AH.
//

import SwiftUI

struct LocationsPreviewView: View {
    
    @EnvironmentObject private var  vm: LocationsViewModel

    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16.0) {
                imageSection
                titleSection
            }
            VStack(spacing: 8) {
                learnMoreButton
                nextButton
            }
        }.padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .offset(y:50)
            )
            .cornerRadius(10)
    }
}

#Preview {
    LocationsPreviewView(location: LocationsDataService.locations.first!).environmentObject(LocationsViewModel())
}

extension LocationsPreviewView{
    private var imageSection: some View {
        ZStack{
            if let imageNames = location.imageNames.first{
                Image(imageNames)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 100)
                    .cornerRadius(10)
                
            }
        }.padding(6)
            .background(.white)
            .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)

        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button(action: {
            vm.sheetLocation = location
        }, label: {
            Text("Learn More").font(.headline).frame(width: 125,height: 35)
        }).buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button(action: {
            vm.nexyButtonPressed()
        }, label: {
            Text("Play").font(.headline).frame(width: 125,height: 35)
        }).buttonStyle(.bordered)
    }

}
