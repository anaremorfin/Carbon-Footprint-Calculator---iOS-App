//
//  ResultsTextViewController.swift
//  CFC
//
//  Created by Regina on 05/05/22.
//

import Foundation
import UIKit

class ResultsTextViewController: UIViewController {
    //IBOutlets
    @IBOutlet weak var emissionsText: UITextField!
    @IBOutlet weak var nationalAverageText: UITextField!
    @IBOutlet weak var internationalAverageText: UITextField!
    @IBOutlet weak var compareText: UITextField!
    
    //let
    let modelo = CFCView()
    //var
    var totalEmissions = 0.0
    var nationalEmissions = 0.0
    var internationalEmissions = 0.0
    var compareEmissions = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Actualiza los datos ingresados con el fin de que el usuario pueda "jugar" y comparar el impacto de diferentes acciones en la huella de carbón.
    @IBAction func updateData(_ sender: Any) {
        //National Average
        nationalEmissions = modelo.nationalAverage()
        nationalAverageText.text = String(format: "%.2f", nationalEmissions) + " Toneladas CO2"
        //International Average
        internationalEmissions = modelo.internationalAverage()
        internationalAverageText.text = String(format: "%.2f", internationalEmissions) + " Toneladas CO2"
        //Total Emissions
        totalEmissions = modelo.totalEmissions()
        emissionsText.text = String(format: "%.2f", totalEmissions) + " Toneladas CO2"
        //Compare
        compareEmissions = modelo.comparacion()
        compareText.text = String(format: "%.0f", compareEmissions) + " árboles medianos al año."
    }
    
}

