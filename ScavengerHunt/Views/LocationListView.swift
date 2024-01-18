//
//  LocationListView.swift
//  ScavengerHunt
//
//  Created by Juman Dhaher on 05/07/1445 AH.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject private var  vm: LocationsViewModel
    
    var body: some View {
        List{
            ForEach(vm.locations) { location in
                Button(action: {
                    vm.showNextLocation(location: location)
                }, label: {
                    listRowsView(location: location).padding(.vertical, 4)       
                }).listRowBackground(Color.clear)
            }
        }.listStyle(PlainListStyle())
    }
}

struct LocationListView_Previews: PreviewProvider{
    static var previews: some View{
        LocationListView().environmentObject(LocationsViewModel())
    }
}


extension LocationListView{
    private func listRowsView(location: Location) -> some View{
        HStack{
            if let imageName = location.imageNames.first{
                Image(imageName).resizable().scaledToFit().frame(width: 45, height: 45).cornerRadius(10)
            }
            VStack(alignment: .leading){
                Text(location.name).font(.headline)
                Text(location.cityName).font(.subheadline)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
