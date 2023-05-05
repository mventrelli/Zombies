//
//  PlottingData.swift
//  Zombies
//
//  Created by IIT PHYS 440 on 5/1/23.
//
import SwiftUI
import Foundation

struct DataVal: Identifiable {
    var id: Double {time}
    var time: Double
    var population: Double

    
}

class PlotClass: ObservableObject {
    
    @Published var Species: String = "Species"
    @Published var Susceptible = [DataVal]()
    @Published var Zombies = [DataVal]()
    @Published var Time = [DataVal]()
    @Published var Population = [DataVal]()
    
 
    }
    

   

    

