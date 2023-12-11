//
//  Transporte3ViewController.swift
//  CFC
//
//  Created by Regina on 04/05/22.
//

import Foundation
import UIKit

class Transporte3ViewController: UIViewController {
    //IBOutlets
    //Insert Text
    @IBOutlet weak var autoDistanceText: UITextField!
    @IBOutlet weak var datoAutoText: UITextField!
    @IBOutlet weak var numPasajeros: UITextField!
    
    //PopUp Buttons
    @IBOutlet weak var autoPopUp: UIButton!
    @IBOutlet weak var modeloAutoPopUp: UIButton!
    @IBOutlet weak var tipoVueloPopUp: UIButton!
    
    //Selected options from PopUp Buttons
    @IBOutlet weak var autoSelectionUP: UITextField!
    @IBOutlet weak var modeloAutoSelectedUp: UITextField!
    @IBOutlet weak var tipoVueloSelectedUp: UITextField!
    
    //Segmented Control
    @IBOutlet weak var autoSegmentedControl: UISegmentedControl!
    @IBOutlet weak var datoAutoSegmentedControl: UISegmentedControl!
    @IBOutlet weak var vueloRISegmentedConttrol: UISegmentedControl!
    
    //Buttons control
    @IBOutlet weak var addButtonC: UIButton!
    @IBOutlet weak var deleteButtonC: UIButton!
    
    //var
    var autoYN = ""
    var datoAutoYN = ""
    var vueloYN = ""
    
    let modelo = CFCView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedAutoYN = UserDefaults.standard.object(forKey: "autoYNUser") as? String
        if (selectedAutoYN == "") {
            print("No data")
        } else {
            if (selectedAutoYN == "Si"){
                autoSegmentedControl.selectedSegmentIndex = 0
            }
            else
            {
                autoSegmentedControl.selectedSegmentIndex = 1
            }
        }
        
        let selectedDatoAutoYN = UserDefaults.standard.object(forKey: "datoAutoYNUser") as? String
        if (selectedDatoAutoYN == "") {
            print("No data")
        } else {
            if (selectedDatoAutoYN == "Si"){
                datoAutoSegmentedControl.selectedSegmentIndex = 0
            }
            else
            {
                datoAutoSegmentedControl.selectedSegmentIndex = 1
            }
        }
        
        let selectedVueloYN = UserDefaults.standard.object(forKey: "vueloYNUser") as? String
        if (selectedVueloYN == "") {
            print("No data")
        } else {
            if (selectedVueloYN == "Redondo"){
                vueloRISegmentedConttrol.selectedSegmentIndex = 0
            }
            else
            {
                vueloRISegmentedConttrol.selectedSegmentIndex = 1
            }
        }
        //Cargar Textviews
        retrieveData()
         
        //Cargar información de Segmented Controls
        retrieveOptionAuto()
        retrieveOptionModeloAuto()
        retrieveOptionVuelo()
         
        //Pop Up Buttons
        setPopButtonAuto()
        setPopButtonModeloAuto()
        setPopButtonVuelo()
    }
    
    //IBActions
    //Segmented Control
    @IBAction func autoSC(_ sender: Any) {
        switch autoSegmentedControl.selectedSegmentIndex{
        case 0:
            autoYN = "Si"
            UserDefaults.standard.set(autoYN, forKey: "autoYNUser")
        case 1:
            autoYN = "No"
            UserDefaults.standard.set(autoYN, forKey: "autoYNUser")
        default:
            break
        }
        print(autoYN)
    }
    @IBAction func datoAutoSC(_ sender: Any) {
        switch datoAutoSegmentedControl.selectedSegmentIndex{
        case 0:
            datoAutoYN = "Si"
            UserDefaults.standard.set(datoAutoYN, forKey: "datoAutoYNUser")
        case 1:
            datoAutoYN = "No"
            UserDefaults.standard.set(datoAutoYN, forKey: "datoAutoYNUser")
        default:
            break
        }
        print(datoAutoYN)
    }
    @IBAction func vueloRISC(_ sender: Any) {
        switch vueloRISegmentedConttrol.selectedSegmentIndex{
        case 0:
            vueloYN = "Redondo"
            UserDefaults.standard.set(vueloYN, forKey: "vueloYNUser")
        case 1:
            vueloYN = "Sólo ida"
            UserDefaults.standard.set(vueloYN, forKey: "vueloYNUser")
        default:
            break
        }
        print(vueloYN)
    }
    
    //ok
    @IBAction func okAutoDistance(_ sender: Any) {
        var autoDistance = autoDistanceText.text!
        if let verifica = Double(autoDistance){
            UserDefaults.standard.set(autoDistance, forKey: "autoDistanceUser")
            print(verifica)
        } else {
            autoDistance = "0.0"
            UserDefaults.standard.set(autoDistance, forKey: "autoDistanceUser")
        }
        autoDistanceText.resignFirstResponder()
    }
    @IBAction func okDatoAuto(_ sender: Any) {
        var datoAuto = datoAutoText.text!
        if let verifica = Double(datoAuto){
            UserDefaults.standard.set(datoAuto, forKey: "datoAutoTextUser")
            print(verifica)
        } else {
            datoAuto = "0.0"
            UserDefaults.standard.set(datoAuto, forKey: "datoAutoTextUser")
        }
        datoAutoText.resignFirstResponder()
    }
    @IBAction func okNumPasaj(_ sender: Any) {
        var passengers = numPasajeros.text!
        if let verifica = Int(passengers){
            UserDefaults.standard.set(passengers, forKey: "autoPassengersUser")
            print(verifica)
        } else {
            passengers = "0"
            UserDefaults.standard.set(passengers, forKey: "autoPassengersUser")
        }
        numPasajeros.resignFirstResponder()
    }
    
    //Flight buttons
    //Borrar registro
    @IBAction func deleteRegister(_ sender: Any) {
        print("Entre a borrar")
        let vueloAcumulado = 0
        UserDefaults.standard.set(vueloAcumulado, forKey: "vueloAcUser")
        print(vueloAcumulado)
        tipoVueloSelectedUp.text = "Seleccione"
        UserDefaults.standard.set("Seleccione", forKey: "vueloHabitUser")
        //let optionToLoad = UserDefaults.standard.object(forKey: "vueloAcUser")
        //print("Reset:", optionToLoad ?? 0.00)
        modelo.resetVueloAc()
    }
    
    //Agregar vuelo
    @IBAction func addFlight(_ sender: Any) {
        print("Entre a agegar")
        let vueloAC = modelo.vuelosAcumulados()
        print("Vuelo acumulado Ready: ",vueloAC)
        let flight = String(vueloAC)
        UserDefaults.standard.set(flight, forKey: "vueloAcUser")
        //let optionToLoad = UserDefaults.standard.object(forKey: "vueloAcUser")
        //print("Inmediato:", optionToLoad ?? 0.00)
    }
    
    //Set PopUp Buttons
    func setPopButtonAuto(){
        let optionClosure = {
            (action : UIAction) in
            let autoHabit = action.title
            print(autoHabit)
            UserDefaults.standard.set(autoHabit, forKey: "autoHabitUser")
            self.autoSelectionUP.text = autoHabit
        }
        autoPopUp.menu = UIMenu(children : [
            UIAction(title : "Seleccione", handler: optionClosure),
            UIAction(title : "Semana", handler: optionClosure),
            UIAction(title : "Mes", handler: optionClosure),
            UIAction(title : "Año", handler: optionClosure),
        ])
        autoPopUp.showsMenuAsPrimaryAction = true
        autoPopUp.changesSelectionAsPrimaryAction = true
    }
    
    func setPopButtonModeloAuto(){
        let optionClosure = {
            (action : UIAction) in
            let modeloAutoHabit = action.title
            print(modeloAutoHabit)
            UserDefaults.standard.set(modeloAutoHabit, forKey: "modeloAutoHabitUser")
            self.modeloAutoSelectedUp.text = modeloAutoHabit
        }
        modeloAutoPopUp.menu = UIMenu(children : [
            UIAction(title : "Seleccione", handler: optionClosure),
            UIAction(title : "Compacto", handler: optionClosure),
            UIAction(title : "Sedan/Hatchback", handler: optionClosure),
            UIAction(title : "Coupe", handler: optionClosure),
            UIAction(title : "SUV", handler: optionClosure),
            UIAction(title : "Minivan", handler: optionClosure),
            UIAction(title : "Pickup", handler: optionClosure),
            UIAction(title : "Compacto Híbrido", handler: optionClosure),
            UIAction(title : "Sedán/Hatchback Híbrido", handler: optionClosure),
            UIAction(title : "Coupe Híbrido", handler: optionClosure),
            UIAction(title : "SUV Híbrido", handler: optionClosure),
            UIAction(title : "Minivan Híbrido", handler: optionClosure),
            UIAction(title : "Pickup Híbrido", handler: optionClosure),
        ])
        modeloAutoPopUp.showsMenuAsPrimaryAction = true
        modeloAutoPopUp.changesSelectionAsPrimaryAction = true
    }
    
    func setPopButtonVuelo(){
        let optionClosure = {
            (action : UIAction) in
            let vueloHabit = action.title
            print(vueloHabit)
            UserDefaults.standard.set(vueloHabit, forKey: "vueloHabitUser")
            self.tipoVueloSelectedUp.text = vueloHabit
        }
        tipoVueloPopUp.menu = UIMenu(children : [
            UIAction(title : "Seleccione", handler: optionClosure),
            UIAction(title : "Nacional", handler: optionClosure),
            UIAction(title : "E.U.", handler: optionClosure),
            UIAction(title : "Canadá", handler: optionClosure),
            UIAction(title : "Centro América", handler: optionClosure),
            UIAction(title : "Suramérica Norte", handler: optionClosure),
            UIAction(title : "Suramérica Sur", handler: optionClosure),
            UIAction(title : "Europa", handler: optionClosure),
            UIAction(title : "África", handler: optionClosure),
            UIAction(title : "Medio Oriente", handler: optionClosure),
            UIAction(title : "Asia", handler: optionClosure),
            UIAction(title : "Oceanía", handler: optionClosure),
        ])
        tipoVueloPopUp.showsMenuAsPrimaryAction = true
        tipoVueloPopUp.changesSelectionAsPrimaryAction = true
    }
    
    //Recuperar información guardada
    func retrieveOptionAuto(){
        let optionToLoad = UserDefaults.standard.object(forKey: "autoHabitUser") as? String
        if (optionToLoad == "") {
            print("No data")
        } else {
            autoSelectionUP.text = optionToLoad
        }
    }
    
    func retrieveOptionModeloAuto(){
        let optionToLoad = UserDefaults.standard.object(forKey: "modeloAutoHabitUser") as? String
        if (optionToLoad == "") {
            print("No data")
        } else {
            modeloAutoSelectedUp.text = optionToLoad
        }
    }
    
    func retrieveOptionVuelo(){
        let optionToLoad = UserDefaults.standard.object(forKey: "vueloHabitUser") as? String
        if (optionToLoad == "") {
            print("No data")
        } else {
            tipoVueloSelectedUp.text = optionToLoad
        }
    }
    
    //Cargar información a Textviews
    func retrieveData(){
        let autoDistanceToInsert = UserDefaults.standard.object(forKey: "autoDistanceUser") as? String
        if (autoDistanceToInsert == "") {
            print("No data")
        } else {
            autoDistanceText.text = autoDistanceToInsert
        }
        let datoAutoToInsert = UserDefaults.standard.object(forKey: "datoAutoTextUser") as? String
        if (datoAutoToInsert == "") {
            print("No data")
        } else {
            datoAutoText.text = datoAutoToInsert
        }
        let passangersToInsert = UserDefaults.standard.object(forKey: "autoPassengersUser") as? String
        if (passangersToInsert == "") {
            print("No data")
        } else {
            numPasajeros.text = passangersToInsert
        }
    }
}
