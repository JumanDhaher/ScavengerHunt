//
//  ScavengerHuntApp.swift
//  ScavengerHunt
//
//  Created by Juman Dhaher on 03/07/1445 AH.
//

import SwiftUI

@main
struct ScavengerHuntApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView().environmentObject(vm)
        }
    }
}
