//
//  Transporte2ViewController.swift
//  CFC
//
//  Created by Regina on 04/05/22.
//

import Foundation
import UIKit

class Transporte2ViewController: UIViewController {
    //IBOutlets
    //Insert Text
    @IBOutlet weak var metroDistanceText: UITextField!
    @IBOutlet weak var busDistanceText: UITextField!
    @IBOutlet weak var motoDistanceText: UITextField!
    @IBOutlet weak var datoMotoText: UITextField!
    
    
    //PopUp Buttons
    @IBOutlet weak var metroPopUp: UIButton!
    @IBOutlet weak var busPopUp: UIButton!
    @IBOutlet weak var motoPopUp: UIButton!
    @IBOutlet weak var modeloMotoPopUp: UIButton!
    
    //Selected options from PopUp Buttons
    @IBOutlet weak var metroSelectionPU: UITextField!
    @IBOutlet weak var busSelectionPU: UITextField!
    @IBOutlet weak var motoSelectionPU: UITextField!
    @IBOutlet weak var modeloMotoSelectionPU: UITextField!
    
    
   //Segmented Control
    @IBOutlet weak var metroSegmentedControl: UISegmentedControl!
    @IBOutlet weak var busSegmentedControl: UISegmentedControl!
    @IBOutlet weak var motoSegmentedControl: UISegmentedControl!
    @IBOutlet weak var datoMotoSegmentedControl: UISegmentedControl!
    
    //var
    var metroYN = ""
    var busYN = ""
    var motoYN = ""
    var datoMotoYN = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedMetroYN = UserDefaults.standard.object(forKey: "metroYNUser") as? String
        if (selectedMetroYN == "") {
            print("No data")
        } else {
            if (selectedMetroYN == "Si"){
                metroSegmentedControl.selectedSegmentIndex = 0
            }
            else
            {
                metroSegmentedControl.selectedSegmentIndex = 1
            }
        }
        
        let selectedBusYN = UserDefaults.standard.object(forKey: "busYNUser") as? String
        if (selectedBusYN == "") {
            print("No data")
        } else {
            if (selectedBusYN == "Si"){
                busSegmentedControl.selectedSegmentIndex = 0
            }
            else
            {
                busSegmentedControl.selectedSegmentIndex = 1
            }
        }
        
        let selectedMotoYN = UserDefaults.standard.object(forKey: "motoYNUser") as? String
        if (selectedMotoYN == "") {
            print("No data")
        } else {
            if (selectedMotoYN == "Si"){
                motoSegmentedControl.selectedSegmentIndex = 0
            }
            else
            {
                motoSegmentedControl.selectedSegmentIndex = 1
            }
        }
        
        let selectedDatoMotoYN = UserDefaults.standard.object(forKey: "datoMotoYNUser") as? String
        if (selectedDatoMotoYN == "") {
            print("No data")
        } else {
            if (selectedDatoMotoYN == "Si"){
                datoMotoSegmentedControl.selectedSegmentIndex = 0
            }
            else
            {
                datoMotoSegmentedControl.selectedSegmentIndex = 1
            }
        }
        //Load Textviews
        retrieveData()
        //Load Segmented Control data
        retrieveOptionBus()
        retrieveOptionMetro()
        retrieveOptionMoto()
        retrieveOptionModeloMoto()
        //Set up Pop Up Buttons
        setPopButtonBus()
        setPopButtonMetro()
        setPopButtonMoto()
        setPopButtonModeloMoto()
    }
    
    //IBActions
    //Segmented Control
    @IBAction func metroSC(_ sender: Any) {
        switch metroSegmentedControl.selectedSegmentIndex{
        case 0:
            metroYN = "Si"
            UserDefaults.standard.set(metroYN, forKey: "metroYNUser")
        case 1:
            metroYN = "No"
            UserDefaults.standard.set(metroYN, forKey: "metroYNUser")
        default:
            break
        }
        print(metroYN)
    }
    @IBAction func busSC(_ sender: Any) {
        switch busSegmentedControl.selectedSegmentIndex{
        case 0:
            busYN = "Si"
            UserDefaults.standard.set(busYN, forKey: "busYNUser")
        case 1:
            busYN = "No"
            UserDefaults.standard.set(busYN, forKey: "busYNUser")
        default:
            break
        }
        print(busYN)
    }
    @IBAction func motoSC(_ sender: Any) {
        switch motoSegmentedControl.selectedSegmentIndex{
        case 0:
            motoYN = "Si"
            UserDefaults.standard.set(motoYN, forKey: "motoYNUser")
        case 1:
            motoYN = "No"
            UserDefaults.standard.set(motoYN, forKey: "motoYNUser")
        default:
            break
        }
        print(motoYN)
    }
    @IBAction func datoMotoSC(_ sender: Any) {
        switch datoMotoSegmentedControl.selectedSegmentIndex{
        case 0:
            datoMotoYN = "Si"
            UserDefaults.standard.set(datoMotoYN, forKey: "datoMotoYNUser")
        case 1:
            datoMotoYN = "No"
            UserDefaults.standard.set(datoMotoYN, forKey: "datoMotoYNUser")
        default:
            break
        }
        print(datoMotoYN)
    }
    
    //ok Buttons: Guardan información proporcionada por el usuario
    @IBAction func okMetroDistance(_ sender: Any) {
        var metroDistance = metroDistanceText.text!
        if let verifica = Double(metroDistance){
            UserDefaults.standard.set(metroDistance, forKey: "metroDistanceUser")
            print(verifica)
        } else {
            metroDistance = "0.0"
            UserDefaults.standard.set(metroDistance, forKey: "metroDistanceUser")
        }
        metroDistanceText.resignFirstResponder()
    }
    @IBAction func okBusDistance(_ sender: Any) {
        var busDistance = busDistanceText.text!
        if let verifica = Double(busDistance){
            UserDefaults.standard.set(busDistance, forKey: "busDistanceUser")
            print(verifica)
        } else {
            busDistance = "0.0"
            UserDefaults.standard.set(busDistance, forKey: "busDistanceUser")
        }
        busDistanceText.resignFirstResponder()
    }
    @IBAction func okMotoDistance(_ sender: Any) {
        var motoDistance = motoDistanceText.text!
        if let verifica = Double(motoDistance){
            UserDefaults.standard.set(motoDistance, forKey: "motoDistanceUser")
            print(verifica)
        } else {
            motoDistance = "0.0"
            UserDefaults.standard.set(motoDistance, forKey: "motoDistanceUser")
        }
        motoDistanceText.resignFirstResponder()
    }
    @IBAction func okDatoMotoValue(_ sender: Any) {
        var datoMoto = datoMotoText.text!
        if let verifica = Double(datoMoto){
            UserDefaults.standard.set(datoMoto, forKey: "datoMotoTextUser")
            print(verifica)
        } else {
            datoMoto = "0.0"
            UserDefaults.standard.set(datoMoto, forKey: "datoMotoTextUser")
        }
        datoMotoText.resignFirstResponder()
    }
    
    //Set Pop Up Buttons
    func setPopButtonMetro(){
        let optionClosure = {
            (action : UIAction) in
            let metroHabit = action.title
            print(metroHabit)
            UserDefaults.standard.set(metroHabit, forKey: "metroHabitUser")
            self.metroSelectionPU.text = metroHabit
        }
        metroPopUp.menu = UIMenu(children : [
            UIAction(title : "Seleccione", handler: optionClosure),
            UIAction(title : "Semana", handler: optionClosure),
            UIAction(title : "Mes", handler: optionClosure),
            UIAction(title : "Año", handler: optionClosure),
        ])
        metroPopUp.showsMenuAsPrimaryAction = true
        metroPopUp.changesSelectionAsPrimaryAction = true
    }
    
    func setPopButtonBus(){
        let optionClosure = {
            (action : UIAction) in
            let busHabit = action.title
            print(busHabit)
            UserDefaults.standard.set(busHabit, forKey: "busHabitUser")
            self.busSelectionPU.text = busHabit
        }
        busPopUp.menu = UIMenu(children : [
            UIAction(title : "Seleccione", handler: optionClosure),
            UIAction(title : "Semana", handler: optionClosure),
            UIAction(title : "Mes", handler: optionClosure),
            UIAction(title : "Año", handler: optionClosure),
        ])
        busPopUp.showsMenuAsPrimaryAction = true
        busPopUp.changesSelectionAsPrimaryAction = true
    }
    
    func setPopButtonMoto(){
        let optionClosure = {
            (action : UIAction) in
            let motoHabit = action.title
            print(motoHabit)
            UserDefaults.standard.set(motoHabit, forKey: "motoHabitUser")
            self.motoSelectionPU.text = motoHabit
        }
        motoPopUp.menu = UIMenu(children : [
            UIAction(title : "Seleccione", handler: optionClosure),
            UIAction(title : "Semana", handler: optionClosure),
            UIAction(title : "Mes", handler: optionClosure),
            UIAction(title : "Año", handler: optionClosure),
        ])
        motoPopUp.showsMenuAsPrimaryAction = true
        motoPopUp.changesSelectionAsPrimaryAction = true
    }
    
    func setPopButtonModeloMoto(){
        let optionClosure = {
            (action : UIAction) in
            let modeloMotoHabit = action.title
            print(modeloMotoHabit)
            UserDefaults.standard.set(modeloMotoHabit, forKey: "modeloMotoHabitUser")
            self.modeloMotoSelectionPU.text = modeloMotoHabit
        }
        modeloMotoPopUp.menu = UIMenu(children : [
            UIAction(title : "Seleccione", handler: optionClosure),
            UIAction(title : "Adventure", handler: optionClosure),
            UIAction(title : "Sport", handler: optionClosure),
            UIAction(title : "Urbana/Scooter", handler: optionClosure),
            UIAction(title : "Tour/Cruiser", handler: optionClosure),
        ])
        modeloMotoPopUp.showsMenuAsPrimaryAction = true
        modeloMotoPopUp.changesSelectionAsPrimaryAction = true
    }
    
    //Recuperar información almacenada en NSDefaults
    func retrieveOptionMetro(){
        let optionToLoad = UserDefaults.standard.object(forKey: "metroHabitUser") as? String
        if (optionToLoad == "") {
            print("No data")
        } else {
            metroSelectionPU.text = optionToLoad
        }
    }
    
    func retrieveOptionBus(){
        let optionToLoad = UserDefaults.standard.object(forKey: "busHabitUser") as? String
        if (optionToLoad == "") {
            print("No data")
        } else {
            busSelectionPU.text = optionToLoad
        }
    }
    
    func retrieveOptionMoto(){
        let optionToLoad = UserDefaults.standard.object(forKey: "motoHabitUser") as? String
        if (optionToLoad == "") {
            print("No data")
        } else {
            motoSelectionPU.text = optionToLoad
        }
    }
    
    func retrieveOptionModeloMoto(){
        let optionToLoad = UserDefaults.standard.object(forKey: "modeloMotoHabitUser") as? String
        if (optionToLoad == "") {
            print("No data")
        } else {
            modeloMotoSelectionPU.text = optionToLoad
        }
    }
    
    //Cargar información a Textviews
    func retrieveData(){
        let metroDistanceToInsert = UserDefaults.standard.object(forKey: "metroDistanceUser") as? String
        if (metroDistanceToInsert == "") {
            print("No data")
        } else {
            metroDistanceText.text = metroDistanceToInsert
        }
        let busDistanceToInsert = UserDefaults.standard.object(forKey: "busDistanceUser") as? String
        if (busDistanceToInsert == "") {
            print("No data")
        } else {
            busDistanceText.text = busDistanceToInsert
        }
        let motoDistanceToInsert = UserDefaults.standard.object(forKey: "motoDistanceUser") as? String
        if (motoDistanceToInsert == "") {
            print("No data")
        } else {
            motoDistanceText.text = motoDistanceToInsert
        }
        let datoMotoToInsert = UserDefaults.standard.object(forKey: "datoMotoTextUser") as? String
        if (datoMotoToInsert == "") {
            print("No data")
        } else {
            datoMotoText.text = datoMotoToInsert
        }
    }
}
