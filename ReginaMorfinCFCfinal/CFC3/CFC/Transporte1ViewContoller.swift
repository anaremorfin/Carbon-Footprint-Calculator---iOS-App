//
//  Transporte1ViewContoller.swift
//  CFC
//
//  Created by Regina on 03/05/22.
//

import Foundation
import UIKit

class Transporte1ViewController: UIViewController {
    //IBOutlets
    //Insert text
    @IBOutlet weak var walkDistanceText: UITextField!
    @IBOutlet weak var bikeDistanceText: UITextField!
    //PopUp Buttons
    @IBOutlet weak var walkPopUp: UIButton!
    @IBOutlet weak var bikePopUp: UIButton!
    //Selected option from PopUP
    @IBOutlet weak var walkSelectionPU: UITextField!
    @IBOutlet weak var bikeSelectionPU: UITextField!
    //SegmentedControl
    @IBOutlet weak var walkSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bikeSegmentedControl: UISegmentedControl!
    //Var
    var walkYN = ""
    var bikeYN = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedWalkYN = UserDefaults.standard.object(forKey: "walkYNUser") as? String
        if (selectedWalkYN == "") {
            print("No data")
        } else {
            if (selectedWalkYN == "Si"){
                walkSegmentedControl.selectedSegmentIndex = 0
            }
            else
            {
                walkSegmentedControl.selectedSegmentIndex = 1
            }
        }
        let selectedBikeYN = UserDefaults.standard.object(forKey: "bikeYNUser") as? String
        if (selectedBikeYN == "") {
            print("No data")
        } else {
            if (selectedBikeYN == "Si"){
                bikeSegmentedControl.selectedSegmentIndex = 0
            }
            else
            {
                bikeSegmentedControl.selectedSegmentIndex = 1
            }
        }
        //Load Textviews
        retrieveData()
        //Load Segmented Control data
        retrieveOptionWalk()
        retrieveOptionBike()
        //Set up Pop Up Buttons
        setPopButtonWalk()
        setPopButtonBike()
    }
    
    //IBActions
    //Segmented controls
    @IBAction func wSC(_ sender: Any) {
        switch walkSegmentedControl.selectedSegmentIndex{
        case 0:
            walkYN = "Si"
            UserDefaults.standard.set(walkYN, forKey: "walkYNUser")
        case 1:
            walkYN = "No"
            UserDefaults.standard.set(walkYN, forKey: "walkYNUser")
        default:
            break
        }
        print(walkYN)
    }
    @IBAction func bSC(_ sender: Any) {
        switch bikeSegmentedControl.selectedSegmentIndex{
        case 0:
            bikeYN = "Si"
            UserDefaults.standard.set(bikeYN, forKey: "bikeYNUser")
        case 1:
            bikeYN = "No"
            UserDefaults.standard.set(bikeYN, forKey: "bikeYNUser")
        default:
            break
        }
        print(bikeYN)
    }
    //okButtons: Guardan información de usuario
    @IBAction func okWalkDistancce(_ sender: Any) {
        var walkingDistance = walkDistanceText.text!
        if let verifica = Double(walkingDistance){
            UserDefaults.standard.set(walkingDistance, forKey: "walkDistanceUser")
            print(verifica)
        } else {
            walkingDistance = "0.0"
            UserDefaults.standard.set(walkingDistance, forKey: "walkDistanceUser")
        }
        walkDistanceText.resignFirstResponder()
    }
    @IBAction func okBikeDistance(_ sender: Any) {
        var bikeDistance = bikeDistanceText.text!
        if let verifica = Double(bikeDistance){
            UserDefaults.standard.set(bikeDistance, forKey: "bikeDistanceUser")
            print(verifica)
        } else {
            bikeDistance = "0.0"
            UserDefaults.standard.set(bikeDistance, forKey: "bikeDistanceUser")
        }
        bikeDistanceText.resignFirstResponder()
    }
    
    //Pop Up Buttons
    func setPopButtonWalk(){
        let optionClosure = {
            (action : UIAction) in
            let walkHabit = action.title
            print(walkHabit)
            UserDefaults.standard.set(walkHabit, forKey: "walkHabitUser")
            self.walkSelectionPU.text = walkHabit
        }
        walkPopUp.menu = UIMenu(children : [
            UIAction(title : "Seleccione", handler: optionClosure),
            UIAction(title : "Semana", handler: optionClosure),
            UIAction(title : "Mes", handler: optionClosure),
            UIAction(title : "Año", handler: optionClosure),
        ])
        walkPopUp.showsMenuAsPrimaryAction = true
        walkPopUp.changesSelectionAsPrimaryAction = true
    }
    
    func setPopButtonBike(){
        let optionClosure = {
            (action : UIAction) in
            let bikeHabit = action.title
            print(bikeHabit)
            UserDefaults.standard.set(bikeHabit, forKey: "bikeHabitUser")
            self.bikeSelectionPU.text = bikeHabit
        }
        bikePopUp.menu = UIMenu(children : [
            UIAction(title : "Seleccione", handler: optionClosure),
            UIAction(title : "Semana", handler: optionClosure),
            UIAction(title : "Mes", handler: optionClosure),
            UIAction(title : "Año", handler: optionClosure),
        ])
        bikePopUp.showsMenuAsPrimaryAction = true
        bikePopUp.changesSelectionAsPrimaryAction = true
    }
    
    //Recuperar información guardada
    func retrieveOptionWalk(){
        let optionToLoad = UserDefaults.standard.object(forKey: "walkHabitUser") as? String
        if (optionToLoad == "") {
            print("No data")
        } else {
            walkSelectionPU.text = optionToLoad
        }
    }
    
    func retrieveOptionBike(){
        let optionToLoad = UserDefaults.standard.object(forKey: "bikeHabitUser") as? String
        if (optionToLoad == "") {
            print("No data")
        } else {
            bikeSelectionPU.text = optionToLoad
        }
    }
    
    //Recuperar información guardada y escribir en Textviews
    func retrieveData(){
        let walkingDistanceToInsert = UserDefaults.standard.object(forKey: "walkDistanceUser") as? String
        if (walkingDistanceToInsert == "") {
            print("No data")
        } else {
            walkDistanceText.text = walkingDistanceToInsert
        }
        
        let bikeDistanceToInsert = UserDefaults.standard.object(forKey: "bikeDistanceUser") as? String
        if (bikeDistanceToInsert == "") {
            print("No data")
        } else {
            bikeDistanceText.text = bikeDistanceToInsert
        }
        
    }
 
}
