//
//  GastosViewController.swift
//  CFC
//
//  Created by Regina on 03/05/22.
//

import Foundation
import UIKit

class GastosViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var expensesText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        
    }
    
    //OK Button: Guarda información proporcionada por usuario
    @IBAction func okExpenses(_ sender: Any) {
        var gasto = expensesText.text!
        expensesText.resignFirstResponder()
        if let verifica = Double(gasto)
        {
            UserDefaults.standard.set(gasto, forKey: "expensesUser")
            print(verifica)
        }
        else {
            gasto = "0.0"
            UserDefaults.standard.set(gasto, forKey: "expensesUser")
        }
    }
    //Carga información
    func retrieveData(){
        let expensesToInsert = UserDefaults.standard.object(forKey: "expensesUser") as? String
        if (expensesToInsert == "") {
            print("No data")
        } else {
            expensesText.text = expensesToInsert
        }
    }
}
