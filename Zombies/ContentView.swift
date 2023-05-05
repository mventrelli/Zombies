//
//  ContentView.swift
//  Zombiessssss!!!
//
//  Created by IIT PHYS 440 on 4/7/23.
//// Parameters

import SwiftUI
import Charts
     
struct ContentView: View {
    //@ObservedObject var myBasicModel = BasicModel()
    @State var tmin: String = "0.0"
    @State var tmax: String = "3600.0"
    @State var tstep: String = "0.05"
    @State var Nmax: String = "1000.0"
    @State var Nstep: String = "1.0"
    @State var eigenValues: String = ""
    @State var alpha: String = "0.005" // Zombie destruction rate
    @State var beta: String = "0.0095" // Transmission rate
    @State var gamma: String = "0.1" //escapees killed
    @State var delta: String = "0.0001" // background death rate
    @State var zeta: String = "0.0001" // Zombie resurrection rate
    @State var pi: String = "0.0" // Birth rate
    @State var rho: String = "0.005" //Infected to zombie
    @State var cured: String = "0.0" //cured zombies
    @State var kappa: String = "0.001" //quarantined infected
    @State var sigma: String = "0.01" //quarantined zombie
    //For Quarantine model, we model kappa, sigma, gamma to satisfy R0 >1 where R0 = (beta*N*rho)/((rho+kappa)(alpha*N+sigma))
    //arbitrary values for kappa, sigma, gamma are .001, .01, and .1 respectfully for the quarantine model
    @State var ealpha: String = "0.0075"
    @State var ebeta: String = "0.0055"
    @State var ezeta: String = "0.09"
    @State var edelta: String = "0.0001"
    @State var ekappa: String = "0.25"
    @State var n: String = String(format: "%.2f", Double.random(in: 0..<1)) // kill ratio for eradication model
    @State var Susceptible: [Double] = []
    @State var Zombies: [Double] = []
    @State var Time: [Double] = []
    @State var Population: [Double] = []
    @State var dataVal = [DataVal]()
    
    
    
    
    @State private var output1: String = ""
    @State private var output2: String = ""
    @State private var output3: String = ""
    @State private var output4: String = ""
    @State private var output5: String = ""
    @State private var output6: String = ""
    @State private var output7: String = ""
    @State private var output8: String = ""
    @State var myPlotClass = PlotClass()
    
    
    
    
    //    struct LineGraphView: View {
    //        @ObservedObject var data: [PlotClass]
    //        var data: [PlotClass]
    //
    //
    //    }
    
    
    var body: some View {
        
        HStack {
            VStack {
                Text("Inputs")
                    .font(.largeTitle)
                
                Group{
                    HStack {
                        Text("tmin: ")
                        TextField("tmin", text: $tmin)
                    }
                    HStack {
                        Text("tmax: ")
                        TextField("tmax", text: $tmax)
                    }
                    HStack {
                        Text("tstep: ")
                        TextField("tstep", text: $tstep)
                    }
                    HStack {
                        Text("Nmax: ")
                        TextField("Nmax", text: $Nmax)
                    }
                    HStack {
                        Text("Nstep: ")
                        TextField("Nstep", text: $Nstep)
                    }
                    HStack {
                        Text("eigenvalues: ")
                        TextField("eigenValues", text: $eigenValues)
                    }
                    HStack {
                        Text("tmin: ")
                        TextField("alpha", text: $alpha)
                    }
                }
                Group{
                    HStack {
                        Text("beta: ")
                        TextField("beta", text: $beta)
                    }
                    HStack {
                        Text("gamma: ")
                        TextField("gamma", text: $gamma)
                    }
                    HStack {
                        Text("delta: ")
                        TextField("delta", text: $delta)
                    }
                    HStack {
                        Text("zeta: ")
                        TextField("zeta", text: $zeta)
                    }
                    HStack {
                        Text("pi: ")
                        TextField("pi", text: $pi)
                    }
                    HStack {
                        Text("rho: ")
                        TextField("rho", text: $rho)
                    }
                    HStack {
                        Text("cured: ")
                        TextField("cured", text: $cured)
                    }
                    HStack {
                        Text("kappa: ")
                        TextField("kappa", text: $kappa)
                    }
                    HStack {
                        Text("sigma: ")
                        TextField("sigma", text: $sigma)
                    }
                }
                HStack {
                    Button("Basic Model") {
                        calculateBasicModel()
                    }
                    Button("Latent Model") {
                        calculateLatentModel()
                    }
                    Button("Quarantine Model") {
                        calculateQuarantineModel()
                    }
                    Button("Treatment Model") {
                        calculateTreatmentModel()
                    }
                    Button("Eradication Model") {
                        calculateEradicationModel()
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
                VStack {
                    Chart{
                        ForEach(dataVal, id: \.time) { item in
                            LineMark(
                                x: .value("Time", item.time),
                                y: .value("Population", item.population)
                            )
                            //            .foregroundStyle(by: .value("Species", myPlotClass.Species))
                        }.foregroundStyle(.blue)        }
                    .padding()
                }
                .padding()
            }
            .padding()
        }
    }
    func calculateSolutions(_ Susceptible: Double, _ Zombie: Double, _ Removed: Double) -> Double {
        
        
        return(2.0)
        
    }
    
    
    func calculateBasicModel() {
        myPlotClass = PlotClass()
        let N = 500.0
        // Initial conditions
        var initialS:[DataVal] = []
        var initialZ:[DataVal] = []
        var initialR:[DataVal] = []
        //var initialI:[Double] = []
        var time:Double = 0.0
        initialS.append(DataVal(time:0.0, population:N-1))
        initialZ.append(DataVal(time:0.0, population:1.0))
        initialR.append(DataVal(time:0.0, population:0.0))
        //        time.append(0.0)
        let timeStep = Double(tstep)!
        let betaDouble = Double(beta)!
        let deltaDouble = Double(delta)!
        let zetaDouble = Double(zeta)!
        let alphaDouble = Double(alpha)!
        let piDouble = Double(pi)!
        for i in 1...500 {
            
            
            
            time = time+timeStep
            
            
            let bsPrime = piDouble + (-betaDouble * initialS[i-1].population * initialZ[i-1].population) + (-deltaDouble  * initialS[i-1].population)
            let bzPrime = (betaDouble*initialS[i-1].population*initialZ[i-1].population)+(zetaDouble*initialR[i-1].population) - (alphaDouble*initialS[i-1].population*initialZ[i-1].population)
            let brPrime = deltaDouble*initialS[i-1].population + alphaDouble*initialS[i-1].population*initialZ[i-1].population-zetaDouble*initialR[i-1].population
            
            let Sofn = initialS[i-1].population+timeStep*bsPrime
            let Zofn = initialZ[i-1].population+timeStep*bzPrime
            let Rofn = initialR[i-1].population+timeStep*brPrime
            
            
            //     time.append(currentTime)
            initialS.append(DataVal(time:time ,population: Sofn))
            initialZ.append(DataVal(time:time ,population: Zofn))
            initialR.append(DataVal(time:time ,population: Rofn))
            
            
            
        }
        
        myPlotClass.Zombies = initialZ
        myPlotClass.Susceptible = initialS
        for i in 0 ..< 500 {
            
            
            print("Time: ", time, "Susceptible: ", initialS[i].population, "Zombies: ", initialZ[i].population, "Removed: ", initialR[i].population)
            //This model works correctly
        }
        print(myPlotClass.Susceptible.count)
        dataVal = []
        for i in 0...(myPlotClass.Susceptible.count-1){
            dataVal.append(DataVal(time: myPlotClass.Susceptible[i].time, population: myPlotClass.Susceptible[i].population))
            
        }
        print(myPlotClass.Zombies.count)
        dataVal = []
        for i in 0...(myPlotClass.Zombies.count-1){
            dataVal.append(DataVal(time: myPlotClass.Zombies[i].time, population: myPlotClass.Zombies[i].population))
            
        }
        
        
        
        
        //let infectionrate = beta*N
        
        
    }
    func calculateLatentModel() {
        myPlotClass = PlotClass()
        let N = 500.0
        // Initial conditions
        var initialS:[DataVal] = []
        var initialZ:[DataVal] = []
        var initialR:[DataVal] = []
        var initialI:[DataVal] = []
        var time:Double = 0.0
        initialS.append(DataVal(time: 0.0, population: N-1))
        initialZ.append(DataVal(time: 0.0, population: 1.0))
        initialR.append(DataVal(time: 0.0, population: 0.0))
        initialI.append(DataVal(time: 0.0, population: 0.0))
        //    time.append(0.0)
        
        let timeStep = Double(tstep)!
        let betaDouble = Double(beta)!
        let deltaDouble = Double(delta)!
        let zetaDouble = Double(zeta)!
        let alphaDouble = Double(alpha)!
        let piDouble = Double(pi)!
        let rhoDouble = Double(rho)!
        let kappaDouble = Double(kappa)!
        let sigmaDouble = Double(sigma)!
        for i in 1...500 {
            
            
            
            time = time+timeStep
            
            let lsPrime = (piDouble + (-betaDouble * initialS[i-1].population * initialZ[i-1].population) + (-deltaDouble  * initialS[i-1].population))
            
            let liPrime = (betaDouble*initialS[i-1].population*initialZ[i-1].population) - (rhoDouble*initialI[i-1].population) - (deltaDouble*initialI[i-1].population)
            let lzPrime = (rhoDouble * initialI[i-1].population) + (zetaDouble * initialR[i-1].population) - (alphaDouble * initialS[i-1].population * initialZ[i-1].population)
            let lrPrime = (deltaDouble * initialS[i-1].population) + (deltaDouble * initialI[i-1].population) + (alphaDouble * initialS[i-1].population * initialZ[i-1].population) - (zetaDouble * initialR[i-1].population)
            let Rzero = (betaDouble*N*rhoDouble)/((rhoDouble+kappaDouble)*(alphaDouble*N+sigmaDouble))
            
            
            let Sofn = (initialS[i-1].population+timeStep*lsPrime)
            let Iofn = (initialI[i-1].population+timeStep*liPrime)
            let Zofn = (initialZ[i-1].population+timeStep*lzPrime)
            let Rofn = (initialR[i-1].population+timeStep*lrPrime)
            
            
            //  time.append(currentTime)
            initialS.append(DataVal(time: time, population: Sofn))
            initialI.append(DataVal(time: time, population: Iofn))
            initialZ.append(DataVal(time: time, population: Zofn))
            initialR.append(DataVal(time: time, population: Rofn))
            
            
            print("Rzero is \(Rzero)")
            
        }
        myPlotClass.Zombies = initialZ
        myPlotClass.Susceptible = initialS
        
        
        for i in 0 ..< 500 {
            
            
            print("Time: ", time, "Susceptible: ", initialS[i].population, "Infected: ", initialI[i].population, "Zombies: ", initialZ[i].population, "Removed: ", initialR[i].population)
            //This model does not work
        }
        print(myPlotClass.Susceptible.count)
        dataVal = []
        for i in 0...(myPlotClass.Susceptible.count-1) {
            dataVal.append(DataVal(time: myPlotClass.Susceptible[i].time, population: myPlotClass.Susceptible[i].population))
            
        }
    }
    func calculateQuarantineModel() {
        myPlotClass = PlotClass()
        let N = 500.0
        // Initial conditions
        var initialS:[DataVal] = []
        var initialI:[DataVal] = []
        var initialZ:[DataVal] = []
        var initialR:[DataVal] = []
        var initialQ:[DataVal] = []
        var time: Double = 0.0
        initialS.append(DataVal(time: 0.0, population: N-1))
        initialZ.append(DataVal(time: 0.0, population: 1.0))
        initialR.append(DataVal(time: 0.0, population: 0.0))
        initialI.append(DataVal(time: 0.0, population: 0.0))
        initialQ.append(DataVal(time: 0.0, population: 0.0))
        //    time.append(0.0)
        let timeStep = Double(tstep)!
        let betaDouble = Double(beta)!
        let deltaDouble = Double(delta)!
        let zetaDouble = Double(zeta)!
        let kappaDouble = Double(kappa)!
        let gammaDouble = Double(gamma)!
        let sigmaDouble = Double(sigma)!
        let alphaDouble = Double(alpha)!
        let piDouble = Double(pi)!
        let rhoDouble = Double(rho)!
        for i in 1...500 {
            
            
            
            time = time+timeStep
            
            let qsPrime = piDouble + (-betaDouble * initialS[i-1].population * initialZ[i-1].population) + (-deltaDouble  * initialS[i-1].population)
            
            let qiPrime = round((betaDouble*initialS[i-1].population*initialZ[i-1].population) - (rhoDouble*initialI[i-1].population) - (deltaDouble*initialI[i-1].population) + (-kappaDouble*initialI[i-1].population))
            let qzPrime = round((rhoDouble * initialI[i-1].population) + (zetaDouble * initialR[i-1].population) - (alphaDouble * initialS[i-1].population * initialZ[i-1].population) + (-sigmaDouble * zetaDouble))
            let qrPrime = round((deltaDouble * initialS[i-1].population) + (deltaDouble * initialI[i-1].population) + (alphaDouble * initialS[i-1].population * initialZ[i-1].population) - (zetaDouble * initialR[i-1].population) + (gammaDouble*initialQ[i-1].population))
            let qqPrime = round((kappaDouble * initialI[i-1].population) + (sigmaDouble * initialZ[i-1].population) + (-gammaDouble * initialQ[i-1].population))
            
            
            
            
            let Sofn = initialS[i-1].population+timeStep*qsPrime
            let Iofn = initialI[i-1].population+timeStep*qiPrime
            let Zofn = initialZ[i-1].population+timeStep*qzPrime
            let Rofn = initialR[i-1].population+timeStep*qrPrime
            let Qofn = initialQ[i-1].population + timeStep*qqPrime
            
            //  time.append(currentTime)
            initialS.append(DataVal(time: time, population: Sofn))
            initialZ.append(DataVal(time: time, population: Zofn))
            initialR.append(DataVal(time: time, population: Rofn))
            initialI.append(DataVal(time: time, population: Iofn))
            initialQ.append(DataVal(time: time, population: Qofn))
            
            
            
        }
        myPlotClass.Zombies = initialZ
        myPlotClass.Susceptible = initialS
        
        
        
        for i in 0..<500 {
            
            
            print("Time: ", time, "Susceptible", initialS[i].population, "Zombies: ", initialZ[i].population, "Removed: ", initialR[i].population, "Infected: ", initialI[i].population, "Quarantined: ", initialQ[i].population)
            //This model does not work
        }
        print(myPlotClass.Susceptible.count)
        dataVal = []
        for i in 0...(myPlotClass.Susceptible.count-1) {
            dataVal.append(DataVal(time: myPlotClass.Susceptible[i].time, population: myPlotClass.Susceptible[i].population))
        }
    }
    func calculateTreatmentModel() {
        myPlotClass = PlotClass()
        let N = 500.0
        // Initial conditions
        var initialS:[DataVal] = []
        var initialZ:[DataVal] = []
        var initialR:[DataVal] = []
        var initialI:[DataVal] = []
        var time: Double = 0.0
        initialS.append(DataVal(time: 0.0, population: N-1))
        initialZ.append(DataVal(time: 0.0, population: 1.0))
        initialR.append(DataVal(time: 0.0, population: 0.0))
        initialI.append(DataVal(time: 0.0, population: 0.0))
        // time.append(0.0)
        let timeStep = Double(tstep)!
        let betaDouble = Double(beta)!
        let deltaDouble = Double(delta)!
        let zetaDouble = Double(zeta)!
        let alphaDouble = Double(alpha)!
        let piDouble = Double(pi)!
        let curedDouble = Double(cured)!
        let rhoDouble = Double(rho)!
        for i in 1...500 {
            
            
            
            time = time+timeStep
            
            let tsPrime = piDouble + (-betaDouble * initialS[i-1].population * initialZ[i-1].population) + (-deltaDouble  * initialS[i-1].population) + (curedDouble * initialZ[i-1].population)
            let tiPrime = (betaDouble * initialZ[i-1].population * initialS[i-1].population) + (-rhoDouble * initialI[i-1].population) - (deltaDouble * initialI[i-1].population)
            let tzPrime = (rhoDouble * initialI[i-1].population) + (zetaDouble * initialR[i-1].population) + (-alphaDouble * initialS[i-1].population * initialZ[i-1].population + (-curedDouble * initialZ[i-1].population))
            let trPrime = deltaDouble*initialS[i-1].population + deltaDouble*initialI[i-1].population + (alphaDouble * initialS[i-1].population * initialZ[i-1].population + (-zetaDouble * initialR[i-1].population))
            
            
            
            
            let Sofn = initialS[i-1].population+timeStep*tsPrime
            let Iofn = initialI[i-1].population+timeStep*tiPrime
            let Zofn = initialZ[i-1].population+timeStep*tzPrime
            let Rofn = initialR[i-1].population+timeStep*trPrime
            
            
            // time.append(currentTime)
            initialS.append(DataVal(time: time, population: Sofn))
            initialZ.append(DataVal(time: time, population: Zofn))
            initialR.append(DataVal(time: time, population: Rofn))
            initialI.append(DataVal(time: time, population: Iofn))
            
            
            
        }
        
        myPlotClass.Zombies = initialZ
        myPlotClass.Susceptible = initialS
        
        for i in 0 ..< 500 {
            
            
            print("Time: ", time, "Susceptible: ", initialS[i].population, "Infected: ", initialI[i].population, "Zombies:", initialZ[i].population, "Removed: ", initialR[i].population)
            //Doesn't look like this one works either, but like almost?
        }
        print(myPlotClass.Susceptible.count)
        dataVal = []
        for i in 0...(myPlotClass.Susceptible.count-1) {
            dataVal.append(DataVal(time: myPlotClass.Susceptible[i].time, population: myPlotClass.Susceptible[i].population))
        }
    }
    
    func calculateEradicationModel() {
        let N = 500.0
        // Initial conditions
        var initialS:[DataVal] = []
        var initialZ:[DataVal] = []
        var initialR:[DataVal] = []
        var initialdZ:[DataVal] = []
        var time:Double = 0.0
        initialS.append(DataVal(time:0.0, population:N-1))
        initialZ.append(DataVal(time:0.0, population: 1.0))
        initialR.append(DataVal(time:0.0, population: 0.0) )
        initialdZ.append(DataVal(time:0.0, population: 0.0))
        
        let timeStep = Double(tstep)!
        let betaDouble = Double(beta)!
        let deltaDouble = Double(delta)!
        let zetaDouble = Double(zeta)!
        let kappaDouble = Double(kappa)!
        let alphaDouble = Double(alpha)!
        let piDouble = Double(pi)!
        let nDouble = Double(n)!
        for i in 1...500 {
            
            
            
            time = time + timeStep
            let esPrime = piDouble + (-betaDouble * initialS[i-1].population * initialZ[i-1].population) + (-deltaDouble  * initialS[i-1].population)
            let ezPrime = (betaDouble * initialZ[i-1].population * initialS[i-1].population) + (zetaDouble * initialR[i-1].population) - (alphaDouble * initialS[i-1].population * initialZ[i-1].population)
            let erPrime = (deltaDouble * initialS[i-1].population) + (alphaDouble * initialS[i-1].population * initialZ[i-1].population) + (-zetaDouble * initialR[i-1].population)
            let edzPrime = -kappaDouble*nDouble*initialZ[i-1].population
            
            
            
            let Sofn = initialS[i-1].population + timeStep * esPrime
            let Zofn = initialZ[i-1].population + timeStep * ezPrime
            let Rofn = initialR[i-1].population + timeStep * erPrime
            let dZofn = initialdZ[i-1].population + timeStep * edzPrime
            
            
            // time.append(currentTime)
            initialS.append(DataVal(time:time ,population: Sofn))
            initialZ.append(DataVal(time:time ,population: Zofn))
            initialR.append(DataVal(time:time ,population: Rofn))
            initialdZ.append(DataVal(time:time ,population: dZofn))
            
            
            
        }
        
        myPlotClass.Zombies = initialZ
        myPlotClass.Susceptible = initialS
        //        myPlotClass.Time = time
        
        for i in 0 ..< 500 {
            
            
            print("Time: ", time, "Susceptible: ", initialS[i].population, "Zombies: ", initialZ[i].population, "Removed: ",initialR[i].population, "Zombies killed: ", initialdZ[i].population)
        }
        print(myPlotClass.Susceptible.count)
        dataVal = []
        for i in 0...(myPlotClass.Susceptible.count-1) {
            dataVal.append(DataVal(time: myPlotClass.Susceptible[i].time, population: myPlotClass.Susceptible[i].population))
        }
    }
}
    //let liprime = beta*initialS*initialZ-rho*initialI-delta*initialI
    //let lzprime = rho*initialI+zeta*initialR-alpha*initialS*initialZ
    //let lrprime = delta*initialS+delta*initialI+alpha*initialS*initialZ-zeta*initialR
    
    
    
    
    //let infectionrate = beta*N
    
    

    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

