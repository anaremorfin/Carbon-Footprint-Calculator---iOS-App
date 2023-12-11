//
//  CFCView.swift
//  CFC
//
//  Created by Regina on 03/05/22.
//  MODEL

import Foundation
import UIKit

class CFCView{
    
    //Declare
    var expensesTotal = 0.0
    var nutritionTotal = 0.0
    var energyTotal = 0.0
    var luzTotal = 0.0
    var gasTotal = 0.0
    var transportTotal = 0.0
    var peopleTotal = 1.0
    
    //For expenses: 1.63kgCO2 for every $1.00USD
    let expensesCO2 = 1.63 //kgCO2/$1USD
    let mxn2usd = 0.0495 //Conversion
    //Promedio luz y gas
    let huellaLuz = 0.505 //kgCO2/kWh
    let huellaGasLP = 1.56 //kgCO2/litro
    let huellaGasNatural = 4.65 //kgCO2/$MXN
    //Transportation //Modificar sus huellas
    let huellaMetro = 2.50
    let huellaBus = 6.20
    let huellaMoto = 1.00
    let huellaAuto = 1.00
    //Vuelo
    var vueloAcumulado = 0.0
    
    //National Annual Average (kgCO2)
    func nationalAverage() -> Double {
        let kgToTon = 0.00110231
        let nationalAverageN = 2512.902 * kgToTon
        
        return nationalAverageN
    }
    
    //Interational Annual Average (kgCO2)
    func internationalAverage() -> Double {
        let kgToTon = 0.00110231
        let internationalAverageN = 3946.254 * kgToTon
        return internationalAverageN
    }
    
    //Expenses kgCO2
    func retrieveDataExpenses() -> Double {
        let expensesRecorded = UserDefaults.standard.object(forKey: "expensesUser") as? String
        if (expensesRecorded == nil) {
            print("No data")
            expensesTotal = 0.0
        } else {
            var expensesAux = Double(expensesRecorded ?? "0.0")
            expensesAux = (expensesAux!) * mxn2usd
            expensesTotal = (expensesAux!) * expensesCO2 * 12
        }
        return expensesTotal
    }
    
    
    //Energy
    func retrieveDataEnergy() -> Double {
        let gasTypeRecorded = UserDefaults.standard.object(forKey: "gasTypeUser") as? String
        let gasRecorded = UserDefaults.standard.object(forKey: "gasUser") as? String
        let luzRecorded = UserDefaults.standard.object(forKey: "luzUser") as? String
        let numPeopleEnergyRecorded = UserDefaults.standard.object(forKey: "numPeopleEnergyUser") as? String
        //Luz (luzTotal)
        if (luzRecorded == "") {
            print("No data")
            luzTotal = 0.0
        } else {
            let luzAux = Double(luzRecorded ?? "0.0")
            //Editar según calculo
            luzTotal = luzAux! * 12 * huellaLuz
        }
        //Gas (gasTotal)
        if (gasTypeRecorded == "") {
            print("No data")
        } else {
            switch gasTypeRecorded {
            case "LP":
                if (gasRecorded == nil) {
                    print("No data")
                    gasTotal = 0.0
                } else {
                    let gasAux = Double(gasRecorded ?? "0.0")
                    //Editar según calculo
                    gasTotal = gasAux! * 12 * huellaGasLP
                }
            case "Natural":
                if (gasRecorded == nil) {
                    print("No data")
                    gasTotal = 0.0
                } else {
                    let gasAux = Double(gasRecorded ?? "0.0")
                    //Editar según calculo
                    gasTotal = gasAux! * 12 * huellaGasNatural
                }
            default:
                break
            }
        }
        //People (peopleEnergy)
        if (numPeopleEnergyRecorded == "") {
            print("No data")
            peopleTotal = 1
        } else {
            let peopleAux = Double(numPeopleEnergyRecorded ?? "0.0")
            peopleTotal = round(peopleAux!)
        }
        
        energyTotal = (luzTotal + gasTotal) / peopleTotal
        return energyTotal
    }
    
    //Nutrition
    func retrieveDataNutrition() -> Double {
        let nutritionRecorded = UserDefaults.standard.object(forKey: "nutritionUser") as? String
        if (nutritionRecorded == nil) {
            print("No data")
            nutritionTotal = 0.0
        } else {
            //Assuming average mexican spends $3000MXN/month in food
            var nutritionAux = 0.0
            switch nutritionRecorded{
            case "Carnívora con consumo alto de carne":
                nutritionAux = 105
            case "Carnívora con consumo medio de carne":
                nutritionAux = 75
            case "Carnívora con consumo bajo de carne":
                nutritionAux = 67.5
            case "Pescetariana":
                nutritionAux = 60
            case "Vegetariana":
                nutritionAux = 52.5
            case "Vegana":
                nutritionAux = 45
            default:
                //UIAllert o avisar que opción invalida (en caso de "seleccionar opción")
                break
            }
            //Yearly average
            nutritionTotal = nutritionAux * 12
        }
        return nutritionTotal
    }
    
    //Transport
    
    //Walk
    //Carbon footprint is 0. Returns distance walked (to be used for the suggestions)
    func retrieveDataTransportWalk() -> Double {
        let walkYNRecorded = UserDefaults.standard.object(forKey: "walkYNUser") as? String
        let walkDistanceRecorded = UserDefaults.standard.object(forKey: "walkDistanceUser") as? String
        let walkHabitRecorded = UserDefaults.standard.object(forKey: "walkHabitUser") as? String
        
        var walkTotal = 0.0
        var walkDistance = 0.0
        var walkHabit = 1.0
        
        if (walkYNRecorded == nil) {
            print("No data")
            walkTotal = 0.0
        } else {
            switch walkYNRecorded {
            case "Si":
                if (walkHabitRecorded == nil) {
                    print("No data")
                    walkHabit = 1.0
                } else {
                    switch walkHabitRecorded {
                    case "Semana":
                        walkHabit = 52.142
                    case "Mes":
                        walkHabit = 12.0
                    case "Año":
                        walkHabit = 1.0
                    default:
                        break
                    }
                }
                if (walkDistanceRecorded == "") {
                    print("No data")
                    walkDistance = 0.0
                } else {
                    let walkDistanceAux = Double(walkDistanceRecorded ?? "0.0")
                    walkDistance = walkDistanceAux! * walkHabit
                }
            case "No":
                walkTotal = 0.0
            default:
                break
            }
            walkTotal = walkDistance
            
        }
        return walkTotal
    }
    
    //Bike
    //Carbon footprint is 0. Returns distance (to be used for the suggestions)
    func retrieveDataTransportBike() -> Double {
        let bikeYNRecorded = UserDefaults.standard.object(forKey: "bikeYNUser") as? String
        let bikeDistanceRecorded = UserDefaults.standard.object(forKey: "bikeDistanceUser") as? String
        let bikeHabitRecorded = UserDefaults.standard.object(forKey: "bikeHabitUser") as? String
        
        var bikeTotal = 0.0
        var bikeDistance = 0.0
        var bikeHabit = 1.0
        
        if (bikeYNRecorded == nil) {
            print("No data")
            bikeTotal = 0.0
        } else {
            switch bikeYNRecorded {
            case "Si":
                if (bikeHabitRecorded == nil) {
                    print("No data")
                    bikeHabit = 1.0
                } else {
                    switch bikeHabitRecorded {
                    case "Semana":
                        bikeHabit = 52.142
                    case "Mes":
                        bikeHabit = 12.0
                    case "Año":
                        bikeHabit = 1.0
                    default:
                        break
                    }
                }
                if (bikeDistanceRecorded == nil) {
                    print("No data")
                    bikeDistance = 0.0
                } else {
                    let bikeDistanceAux = Double(bikeDistanceRecorded ?? "0.0")
                    bikeDistance = bikeDistanceAux! * bikeHabit
                }
            case "No":
                bikeTotal = 0.0
                //print("No usa bici")
            default:
                break
            }
            bikeTotal = bikeDistance
            
        }
        return bikeTotal
    }
    
    //Metro
    func retrieveDataTransportMetro() -> Double {
        let metroYNRecorded = UserDefaults.standard.object(forKey: "metroYNUser") as? String
        let metroDistanceRecorded = UserDefaults.standard.object(forKey: "metroDistanceUser") as? String
        let metroHabitRecorded = UserDefaults.standard.object(forKey: "metroHabitUser") as? String
        
        var metroTotal = 0.0
        var metroDistance = 0.0
        var metroHabit = 1.0
        
        if (metroYNRecorded == nil) {
            print("No data")
            metroTotal = 0.0
        } else {
            switch metroYNRecorded {
            case "Si":
                if (metroHabitRecorded == nil) {
                    print("No data")
                    metroHabit = 1.0
                } else {
                    switch metroHabitRecorded {
                    case "Semana":
                        metroHabit = 52.142
                    case "Mes":
                        metroHabit = 12.0
                    case "Año":
                        metroHabit = 1.0
                    default:
                        break
                    }
                }
                if (metroDistanceRecorded == nil) {
                    print("No data")
                    metroDistance = 0.0
                } else {
                    let metroDistanceAux = Double(metroDistanceRecorded ?? "0.0")
                    metroDistance = metroDistanceAux! * metroHabit
                }
            case "No":
                metroTotal = 0.0
                //print("No usa el metro")
            default:
                break
            }
            metroTotal = metroDistance * huellaMetro
        }
        return metroTotal
    }
    
    //Bus
    func retrieveDataTransportBus() -> Double {
        let busYNRecorded = UserDefaults.standard.object(forKey: "busYNUser") as? String
        let busDistanceRecorded = UserDefaults.standard.object(forKey: "busDistanceUser") as? String
        let busHabitRecorded = UserDefaults.standard.object(forKey: "busHabitUser") as? String
        
        var busTotal = 0.0
        var busDistance = 0.0
        var busHabit = 1.0
        
        if (busYNRecorded == nil) {
            print("No data")
            busTotal = 0.0
        } else {
            switch busYNRecorded {
            case "Si":
                if (busHabitRecorded == nil) {
                    print("No data")
                    busHabit = 1.0
                } else {
                    switch busHabitRecorded {
                    case "Semana":
                        busHabit = 52.142
                    case "Mes":
                        busHabit = 12.0
                    case "Año":
                        busHabit = 1.0
                    default:
                        break
                    }
                }
                if (busDistanceRecorded == nil) {
                    print("No data")
                    busDistance = 0.0
                } else {
                    let busDistanceAux = Double(busDistanceRecorded ?? "0.0")
                    busDistance = busDistanceAux! * busHabit
                }
            case "No":
                busTotal = 0.0
                //print("No usa el camión")
            default:
                break
            }
            busTotal = busDistance * huellaBus
        }
        return busTotal
    }
    
    //Moto
    func retrieveDataTransportMoto() -> Double {
        let motoYNRecorded = UserDefaults.standard.object(forKey: "motoYNUser") as? String
        let motoDistanceRecorded = UserDefaults.standard.object(forKey: "motoDistanceUser") as? String
        let motoHabitRecorded = UserDefaults.standard.object(forKey: "motoHabitUser") as? String
        let datoMotoYNRecorded = UserDefaults.standard.object(forKey: "datoMotoYNUser") as? String
        let datoMotoTextRecorded = UserDefaults.standard.object(forKey: "datoMotoTextUser") as? String
        let modeloMotoHabitRecorded = UserDefaults.standard.object(forKey: "modeloMotoHabitUser") as? String
        
        var motoTotal = 0.0
        var motoDistance = 0.0
        var motoHabit = 1.0
        var huellaMotoModel = 0.0
        
        if (motoYNRecorded == nil) {
            print("No data")
            motoTotal = 0.0
        } else {
            switch motoYNRecorded {
            case "Si":
                if (motoHabitRecorded == nil) {
                    print("No data")
                    motoHabit = 1.0
                } else {
                    switch motoHabitRecorded {
                    case "Semana":
                        motoHabit = 52.142
                    case "Mes":
                        motoHabit = 12.0
                    case "Año":
                        motoHabit = 1.0
                    default:
                        break
                    }
                }
                if (motoDistanceRecorded == nil) {
                    print("No data")
                    motoDistance = 0.0
                } else {
                    let motoDistanceAux = Double(motoDistanceRecorded ?? "0.0")
                    motoDistance = motoDistanceAux! * motoHabit
                    //kgCO2 de moto
                    if (datoMotoYNRecorded == nil) {
                        print("No data")
                        //busTotal = 0.0
                    } else {
                        switch datoMotoYNRecorded {
                        case "No":
                            if (modeloMotoHabitRecorded == nil) {
                                print("No data")
                                //busHabit = 1.0
                            } else {
                                switch modeloMotoHabitRecorded {
                                case "Adventure":
                                    huellaMotoModel = 0.110
                                case "Sport":
                                    huellaMotoModel = 0.115
                                case "Urbana/Scooter":
                                    huellaMotoModel = 0.081
                                case "Tour/Cruiser":
                                    huellaMotoModel = 0.137
                                default:
                                    break
                                }
                            }
                        case "Si":
                            let huellaMotoKnown = Double(datoMotoTextRecorded ?? "0.0")
                            huellaMotoModel = huellaMotoKnown!
                        default:
                            break
                        }
                        motoTotal = motoDistance * huellaMotoModel
                    }
                }
            case "No":
                motoTotal = 0.0
            default:
                break
            }
        }
        return motoTotal
    }
    
    //Auto
    func retrieveDataTransportAuto() -> Double {
        let autoYNRecorded = UserDefaults.standard.object(forKey: "autoYNUser") as? String
        let autoDistanceRecorded = UserDefaults.standard.object(forKey: "autoDistanceUser") as? String
        let autoHabitRecorded = UserDefaults.standard.object(forKey: "autoHabitUser") as? String
        let datoAutoYNRecorded = UserDefaults.standard.object(forKey: "datoAutoYNUser") as? String
        let datoAutoTextRecorded = UserDefaults.standard.object(forKey: "datoAutoTextUser") as? String
        let modeloAutoHabitRecorded = UserDefaults.standard.object(forKey: "modeloAutoHabitUser") as? String
        let autoPassengersRecorded = UserDefaults.standard.object(forKey: "autoPassengersUser") as? String
        
        var autoTotal = 0.0
        var autoDistance = 0.0
        var autoHabit = 1.0
        var huellaAutoModel = 0.0
        
        if (autoYNRecorded == nil) {
            print("No data")
            autoTotal = 0.0
        } else {
            switch autoYNRecorded {
            case "Si":
                if (autoHabitRecorded == nil) {
                    print("No data")
                    autoHabit = 1.0
                } else {
                    switch autoHabitRecorded {
                    case "Semana":
                        autoHabit = 52.142
                    case "Mes":
                        autoHabit = 12.0
                    case "Año":
                        autoHabit = 1.0
                    default:
                        break
                    }
                }
                if (autoDistanceRecorded == nil) {
                    print("No data")
                    autoDistance = 0.0
                } else {
                    let autoDistanceAux = Double(autoDistanceRecorded ?? "0.0")
                    autoDistance = autoDistanceAux! * autoHabit
                    //kgCO2 de moto
                    if (datoAutoYNRecorded == nil) {
                        print("No data")
                        //busTotal = 0.0
                    } else {
                        switch datoAutoYNRecorded {
                        case "No":
                            if (modeloAutoHabitRecorded == nil) {
                                print("No data")
                                //busHabit = 1.0
                            } else {
                                switch modeloAutoHabitRecorded {
                                case "Compacto":
                                    huellaAutoModel = 0.138
                                case "Sedan/Hatchback":
                                    huellaAutoModel = 0.195
                                case "Coupe":
                                    huellaAutoModel = 0.265
                                case "SUV":
                                    huellaAutoModel = 0.218
                                case "Minivan":
                                    huellaAutoModel = 0.285
                                case "Pickup":
                                    huellaAutoModel = 0.345
                                case "Compacto Híbrido":
                                    huellaAutoModel = 0.088
                                case "Sedán/Hatchback Híbrido":
                                    huellaAutoModel = 0.124
                                case "Coupe Híbrido":
                                    huellaAutoModel = 0.170
                                case "SUV Híbrido":
                                    huellaAutoModel = 0.140
                                case "Minivan Híbrido":
                                    huellaAutoModel = 0.182
                                case "Pickup Híbrido":
                                    huellaAutoModel = 0.221
                                default:
                                    break
                                }
                            }
                        case "Si":
                            let huellaAutoKnown = Double(datoAutoTextRecorded ?? "0.0")
                            huellaAutoModel = huellaAutoKnown!
                        default:
                            break
                        }
                        autoTotal = autoDistance * huellaAutoModel
                    }
                }
            case "No":
                autoTotal = 0.0
            default:
                break
            }
        }
        var passengersTotal = 0.0
        //People (peopleEnergy)
        if (autoPassengersRecorded == "") {
            print("No data")
            passengersTotal = 1.0
        } else {
            let peopleAux = Double(autoPassengersRecorded ?? "0.0")
            passengersTotal = round(peopleAux!)
        }
        
        autoTotal = autoTotal / passengersTotal
        
        return autoTotal
    }
    
    //Vuelo
    func retrieveDataTransportVuelo() -> Double {
        //Lugar
        let vueloHabitRecorded = UserDefaults.standard.object(forKey: "vueloHabitUser") as? String
        //Tipo
        let vueloTypeRecorded = UserDefaults.standard.object(forKey: "vueloYNUser") as? String
        //var
        var vueloTotal = 0.0
        var tipoVuelo = 0.0
        var vueloAux = 0.0
        
        if (vueloTypeRecorded == nil) {
            print("No data")
        } else {
            switch vueloTypeRecorded {
            case "Redondo":
                tipoVuelo = 2.0
            case "Sólo ida":
                tipoVuelo = 1.0
            default:
                break
            }
        }
        if (vueloHabitRecorded == nil) {
            vueloAux = 0.0
            print("No data")
        } else {
            switch vueloHabitRecorded{
            case "Nacional":
                vueloAux = 285
            case "E.U.":
                vueloAux = 712
            case "Canadá":
                vueloAux = 1140
            case "Centro América":
                vueloAux = 712
            case "Suramérica Norte":
                vueloAux = 980
            case "Suramérica Sur":
                vueloAux = 2280
            case "Europa":
                vueloAux = 2600
            case "África":
                vueloAux = 3705
            case "Medio Oriente":
                vueloAux = 4075
            case "Asia":
                vueloAux = 3705
            case "Oceanía":
                vueloAux = 4275
            default:
                //UIAllert o avisar que opción invalida (en caso de "seleccionar opción")
                break
            }
            //Yearly average
            vueloTotal = vueloAux * tipoVuelo
            UserDefaults.standard.set(vueloTotal, forKey: "vueloNuevo")
        }
        
        return vueloTotal
    }
    
    func vuelosAcumulados() -> Double {
        //Acumulado
        let vueloAc = UserDefaults.standard.object(forKey: "vueloAcUser") as? String
        print("vuelo Ac antes: ", vueloAc as Any)
        let vueloNuevo = retrieveDataTransportVuelo()
        print("Vuelo nuevo: ",vueloNuevo)
        //var vueloAcAux = 0.0
        if (vueloAc == nil) {
            vueloAcumulado = vueloNuevo
            //print("empty: ", vueloAcumulado)
        } else {
            if (vueloAc == "0") {
                vueloAcumulado = vueloNuevo
                //print("0: ", vueloAcumulado)
            } else {
                let vueloAcAux = Double(vueloAc ?? "0.0")
                vueloAcumulado = vueloAcAux! + vueloNuevo
                print("other: ", vueloAcumulado)
            }
        }
        //let vueloAcumulado = vueloNuevo + vueloAcAux
        UserDefaults.standard.set(vueloAcumulado, forKey: "vueloAcUser")
        //print("Vuelo acumulado Modelo: ",vueloAcumulado)
        return vueloAcumulado
    }
    
    func dataTransportVuelo() -> Double {
        let vueloSumRecorded = UserDefaults.standard.object(forKey: "vueloAcUser") as? String
        //print("Lo que hay guardado: ", vueloSumRecorded as Any)
        var vueloSum = 0.0
        if (vueloSumRecorded == nil) {
            print("No data")
            vueloSum = 1.0
        } else {
            let vueloAux = Double(vueloSumRecorded ?? "0.000")
            vueloSum = vueloAux!
        }
        return vueloSum
    }
    
    
    /*func resetVueloAc() -> Double {
        //Vuelo
        vueloAcumulado = 0.0
        return vueloAcumulado
    }*/
    func resetVueloAc() {
        //Vuelo
        vueloAcumulado = 0.0
    }
    
    /*retrieveDataExpenses()
    retrieveDataEnergy()
    retrieveDataNutrition()
    
    retrieveDataTransportMetro()
    retrieveDataTransportBus()
    retrieveDataTransportMoto()
    retrieveDataTransportAuto()
    dataTransportVuelo()
     */
    
    //Total Emissions
    func emissionsTransport() -> Double {
        let emissionsMetroSub = retrieveDataTransportMetro()
        let emissionsBusSub = retrieveDataTransportBus()
        let emissionsMotoSub = retrieveDataTransportMoto()
        let emissionsAutoSub = retrieveDataTransportAuto()
        let emissionsVueloSub = dataTransportVuelo()
        
        let emissionsTransportSub = emissionsMetroSub + emissionsBusSub + emissionsMotoSub + emissionsAutoSub + emissionsVueloSub
        
        return emissionsTransportSub
    }
    
    func totalEmissions() -> Double {
        let gastos = retrieveDataExpenses()
        let energia = retrieveDataEnergy()
        let alimentacion = retrieveDataNutrition()
        let transporte = emissionsTransport()
        
        let kgToTon = 0.00110231
        
        let emisionesTotales = (gastos + energia + alimentacion + transporte) * kgToTon
        
        return emisionesTotales
    }
    
    func comparacion() -> Double {
        //Emisiones en toneladas
        let tonCO2 = totalEmissions()
        //1 ton es igual a lo que absorben 12 arbóles medianos al año
        let arboles = tonCO2 * 12
        return arboles
    }
    
    func sugerencias() -> String {
        let alimentacion = retrieveDataNutrition()
        let walk = retrieveDataTransportWalk()
        let bike = retrieveDataTransportBike()
        let auto = retrieveDataTransportAuto()
        let vuelo = dataTransportVuelo()
        
        let sugerenciaDefault1 = "Consumir productos locales." + "\n"
        let sugerenciaDefault2 = "Participa en campañas de reforestación." + "\n"
        let sugerenciaCarne = "Reducir el consumo de carnes rojas y optar por una alimentación con mayor consumo de frutas, verduras, granos y leguminosas." + "\n"
        let sugerenciaWalk = "Para trayectos cortos procurar caminar." + "\n"
        let sugerenciaBike = "Para trayectos medianos o cortos, usar la bicicleta." + "\n"
        let sugerenciaPublicT = "Usar transporte público o compartir traslados." + "\n"
        let sugerenciaFlight = "Disminuir la cantidad de vuelos y optar por otros medios de transporte." + "\n"
        let sugerenciaEnergia1 = "Optar por energía renovable instalando paneles solares en el techo de su casa." + "\n"
        let sugerenciaEnergia2 = "Reducir el consumo de energía eléctrica, desconectando aparatos eléctricos cuando no estén en uso." + "\n"
        let sugerenciaEnergia3 = "Optando por focos LED." + "\n"
        let sugerenciaDefault3 = "Controlar el consumo de agua." + "\n"
        let sugerenciaDefault4 = "Reducir nuestro consumo y gastos en accesorios que no usamos frecuentemente." + "\n"
        
        //Default
        var textToInsert = sugerenciaDefault1 + sugerenciaDefault2
        
        if (alimentacion >= 810) {
            textToInsert = textToInsert + sugerenciaCarne
        }
        if (walk <= 260) {
            textToInsert = textToInsert + sugerenciaWalk
        }
        if (bike <= 520) {
            textToInsert = textToInsert + sugerenciaBike
        }
        if (auto >= 10) {
            textToInsert = textToInsert + sugerenciaPublicT
        }
        if (vuelo >= 50) {
            textToInsert = textToInsert + sugerenciaFlight
        }
        //Siempre cuidar energía
        textToInsert = textToInsert + sugerenciaEnergia1 + sugerenciaEnergia2 + sugerenciaEnergia3
        //Default
        textToInsert = textToInsert + sugerenciaDefault3 + sugerenciaDefault4
        return textToInsert
        
    }
    
    func sugCompare() -> String {
        let tonCO2 = totalEmissions()
        let national = nationalAverage()
        var comparacionSug = "Tu huella es "
        print(tonCO2)
        print(national)
        if (tonCO2 > national) {
            comparacionSug = comparacionSug + "mayor"
        }
        if (tonCO2 <= national) {
            comparacionSug = comparacionSug + "menor"
        }
        comparacionSug = comparacionSug + " al promedio nacional."
        return comparacionSug
    }
}
