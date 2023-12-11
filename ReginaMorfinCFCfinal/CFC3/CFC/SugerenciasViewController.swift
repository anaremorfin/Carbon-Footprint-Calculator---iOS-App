//
//  SugerenciasViewController.swift
//  CFC
//
//  Created by Regina on 08/05/22.
//

import Foundation
import UIKit

class SugerenciasViewController: UIViewController {
    
    
    @IBOutlet weak var moreLessSug: UITextView!
    @IBOutlet weak var suggestionsTextView: UITextView!
    
    //let
    let modelo = CFCView()
    //var
    var compEmissions = ""
    var sugerencias = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Carga la lista personalizada de sugerencias y compara lass emisiones del usuario con las del promedio
    @IBAction func actualizar(_ sender: Any) {
        compEmissions = modelo.sugCompare()
        moreLessSug.text = compEmissions
        sugerencias = modelo.sugerencias()
        suggestionsTextView.text = sugerencias
    }
}
