//
//  EnergiaViewController.swift
//  CFC
//
//  Created by Regina on 03/05/22.
//

import Foundation
import UIKit

class EnergiaViewController: UIViewController {

    //IBOutlets
    //Textviews
    @IBOutlet weak var numeroPersonasText: UITextField!
    @IBOutlet weak var luzText: UITextField!
    @IBOutlet weak var gasLPText: UITextField!
    //Segmented Control
    @IBOutlet weak var tipoGasSegmentedControl: UISegmentedControl!
    var tipoGas = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedGasType = UserDefaults.standard.object(forKey: "gasTypeUser") as? String
        if (selectedGasType == "") {
            print("No data")
        } else {
            if (selectedGasType == "LP"){
                tipoGasSegmentedControl.selectedSegmentIndex = 0
            }
            else
            {
                tipoGasSegmentedControl.selectedSegmentIndex = 1
            }
        }
        retrieveScore()
    }

    //IBActions
    
    @IBAction func typeOfGas(_ sender: Any) {
        switch tipoGasSegmentedControl.selectedSegmentIndex{
        case 0:
            tipoGas = "LP"
            UserDefaults.standard.set(tipoGas, forKey: "gasTypeUser")
        case 1:
            tipoGas = "Natural"
            UserDefaults.standard.set(tipoGas, forKey: "gasTypeUser")
        default:
            break
        }
        print(tipoGas)
    }
    
    //OK Buttons: Guarda la información proporcionada por el usuario
    @IBAction func okNumPersButton(_ sender: Any) {
        var numberPeople = numeroPersonasText.text!
        if let verifica = Int(numberPeople) {
            UserDefaults.standard.set(numberPeople, forKey: "numPeopleEnergyUser")
            print(verifica)
        } else {
            numberPeople = "0"
            UserDefaults.standard.set(numberPeople, forKey: "numPeopleEnergyUser")
        }
        numeroPersonasText.resignFirstResponder()
    }
    @IBAction func okLuzButton(_ sender: Any) {
        var luzCant = luzText.text!
        if let verifica = Double(luzCant) {
            UserDefaults.standard.set(luzCant, forKey: "luzUser")
            print(verifica)
        } else {
            luzCant = "0.0"
            UserDefaults.standard.set(luzCant, forKey: "luzUser")
        }
        luzText.resignFirstResponder()
    }
    @IBAction func okGasButton(_ sender: Any) {
        var gasCant = gasLPText.text!
        if let verifica = Double(gasCant) {
            UserDefaults.standard.set(gasCant, forKey: "gasUser")
            print(verifica)
        } else {
            gasCant = "0.0"
            UserDefaults.standard.set(gasCant, forKey: "gasUser")
        }
        gasLPText.resignFirstResponder()
    }
        
    //Carga la información guardada a los TextViews
    func retrieveScore(){
        let numPeopleToInsert = UserDefaults.standard.object(forKey: "numPeopleEnergyUser") as? String
        if (numPeopleToInsert == "") {
            print("No data")
        } else {
            numeroPersonasText.text = numPeopleToInsert
        }
        
        let luzToInsert = UserDefaults.standard.object(forKey: "luzUser") as? String
        if (luzToInsert == "") {
            print("No data")
        } else {
            luzText.text = luzToInsert
        }
        
        let gasToInsert = UserDefaults.standard.object(forKey: "gasUser") as? String
        if (gasToInsert == "") {
            print("No data")
        } else {
            gasLPText.text = gasToInsert
        }
    }
}
