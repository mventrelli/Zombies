//
//  ContentView.swift
//  Zombiessssss!!!
//
//  Created by IIT PHYS 440 on 4/7/23.
//// Parameters

import SwiftUI
struct ContentView: View {
    //@ObservedObject var myBasicModel = BasicModel()
    @State var tmin: String = "0.0"
    @State var tmax: String = "3600.0"
    @State var tstep: String = "0.1"
    @State var Nmax: String = "1000.0"
    @State var Nstep: String = "1.0"
    @State var eigenValues: String = ""
    @State var alpha: String = "0.005" // Zombie destruction rate
    @State var beta: String = "0.0095" // Transmission rate
    @State var gamma: String = "0.0" //escapees killed
    @State var delta: String = "0.0001" // background death rate
    @State var zeta: String = "0.0001" // Zombie resurrection rate
    @State var pi: String = "0.0" // Birth rate
    @State var rho: String = "0.005" //doesn't say??
    @State var cured: String = "0.0" //cured zombies
    @State var kappa: String = "0.0" //quarantined infected
    @State var sigma: String = "0.0" //quarantined zombie
  
  
   
   @State private var output1: String = ""
   @State private var output2: String = ""
   @State private var output3: String = ""
   @State private var output4: String = ""
   @State private var output5: String = ""
   @State private var output6: String = ""
   @State private var output7: String = ""
   @State private var output8: String = ""
   
   var body: some View {
       VStack {
           Text("Inputs")
               .font(.largeTitle)
           
           Group{TextField("tmin", text: $tmin)
               TextField("tmax", text: $tmax)
               TextField("tstep", text: $tstep)
               TextField("Nmax", text: $Nmax)
               TextField("Nstep", text: $Nstep)
               TextField("eigenValues", text: $eigenValues)
               TextField("alpha", text: $alpha)
           }
           Group{
               TextField("beta", text: $beta)
               TextField("gamma", text: $gamma)
               TextField("delta", text: $delta)
               TextField("zeta", text: $zeta)
               TextField("pi", text: $pi)
               TextField("rho", text: $rho)
               TextField("cured", text: $cured)
               TextField("kappa", text: $kappa)
               TextField("sigma", text: $sigma)
           }
           HStack {
               Button("Function 1") {
                   calculateBasicModel()
               }
               Button("Function 2") {
                   // Code for function 2
               }
               Button("Function 3") {
                   // Code for function 3
               }
           }
           .padding()
           
//           Text("Outputs")
//               .font(.largeTitle)
//           Text("Output 1: \(output1)")
//           Text("Output 2: \(output2)")
//           Text("Output 3: \(output3)")
//           Text("Output 4: \(output4)")
//           Text("Output 5: \(output5)")
//           Text("Output 6: \(output6)")
//           Text("Output 7: \(output7)")
//           Text("Output 8: \(output8)")
       }
   }
    func calculateSolutions(_ Susceptible: Double, _ Zombie: Double, _ Removed: Double) -> Double {
        
        
        return(2.0)
        
    }
    
    func calculateBasicModel() {
        let N = 500.0
        // Initial conditions
        var initialS:[Double] = []
        var initialZ:[Double] = []
        var initialR:[Double] = []
        //var initialI:[Double] = []
        var time:[Double] = []
        initialS.append(N-1)
        initialZ.append(1.0)
        initialR.append(0.0)
        time.append(0.0)
        let timeStep = Double(tstep)!
        let betaDouble = Double(beta)!
        let deltaDouble = Double(delta)!
        let zetaDouble = Double(zeta)!
        let alphaDouble = Double(alpha)!
        let piDouble = Double(pi)!
        for i in 1...500 {
            
            
            
             let currentTime = time[i-1]+timeStep
            
            
            let bsPrime = piDouble + (-betaDouble * initialS[i-1] * initialZ[i-1]) + (-deltaDouble  * initialS[i-1])
            
            
            let bzPrime = betaDouble*initialS[i-1]*initialZ[i-1]+zetaDouble*initialR[i-1]-alphaDouble*initialS[i-1]*initialZ[i-1]
            let brPrime = deltaDouble*initialS[i-1] + alphaDouble*initialS[i-1]*initialZ[i-1]-zetaDouble*initialR[i-1]
            
           let Sofn = initialS[i-1]+timeStep*bsPrime
            let Rofn = initialR[i-1]+timeStep*brPrime
           let Zofn = initialZ[i-1]+timeStep*bzPrime
            
            time.append(currentTime)
            initialS.append(Sofn)
            initialZ.append(Zofn)
            initialR.append(Rofn)
            
            
            
        }
        
        

        for i in 0..<time.count {
            
            
            print(time[i],initialS[i],initialZ[i],initialR[i])
        }


        
        //let liprime = beta*initialS*initialZ-rho*initialI-delta*initialI
        //let lzprime = rho*initialI+zeta*initialR-alpha*initialS*initialZ
        //let lrprime = delta*initialS+delta*initialI+alpha*initialS*initialZ-zeta*initialR




        //let infectionrate = beta*N

    
    }
    
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
       ContentView()
   }
}
