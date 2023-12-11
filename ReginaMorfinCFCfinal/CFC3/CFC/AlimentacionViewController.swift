//
//  AlimentacionViewController.swift
//  CFC
//
//  Created by Regina on 03/05/22.
//

import Foundation
import UIKit

class AlimentacionViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var nutritionPopButton: UIButton!
    @IBOutlet weak var selectedNutrition: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveOption()
        setPopButton()
    }
    //PopButton opciones y almacenamiento
    func setPopButton(){
        let optionClosure = {
            (action : UIAction) in
            let alimentacion = action.title
            print(alimentacion)
            UserDefaults.standard.set(alimentacion, forKey: "nutritionUser")
            self.selectedNutrition.text = alimentacion
        }
        nutritionPopButton.menu = UIMenu(children : [
            UIAction(title : "Seleccione una opción", handler: optionClosure),
            UIAction(title : "Carnívora con consumo alto de carne", handler: optionClosure),
            UIAction(title : "Carnívora con consumo medio de carne", handler: optionClosure),
            UIAction(title : "Carnívora con consumo bajo de carne", handler: optionClosure),
            UIAction(title : "Pescetariana", handler: optionClosure),
            UIAction(title : "Vegetariana", handler: optionClosure),
            UIAction(title : "Vegana", handler: optionClosure),
        ])
        nutritionPopButton.showsMenuAsPrimaryAction = true
        nutritionPopButton.changesSelectionAsPrimaryAction = true
    }
    //Cargar opción seleccionada
    func retrieveOption(){
        let optionToLoad = UserDefaults.standard.object(forKey: "nutritionUser") as? String
        if (optionToLoad == "") {
            print("No data")
        } else {
            selectedNutrition.text = optionToLoad
        }
    }
}
