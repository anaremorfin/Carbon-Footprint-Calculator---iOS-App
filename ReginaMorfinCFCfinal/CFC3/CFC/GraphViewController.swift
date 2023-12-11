//
//  GraphsViewController.swift
//  CFC
//
//  Created by Regina on 08/05/22.
//

import Foundation
import UIKit

class GraphViewController: UIViewController {
    
    //let
    let modelo = CFCView()
    
    @IBOutlet weak var pieChart: JPieChart!
    @IBOutlet weak var gastosLabel: UITextField!
    @IBOutlet weak var energiaLabel: UITextField!
    @IBOutlet weak var alimentacionLabel: UITextField!
    @IBOutlet weak var transporteLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var gastos = 0.0
    var energia = 0.0
    var alimentacion = 0.0
    var transporte = 0.0

    //Carga la gráfica definida en JPieChart y muestra los valores de cada categoría debajo de su categoría
    @IBAction func refreshClick(_ sender: Any) {
        //Pie Chart
        gastos = modelo.retrieveDataExpenses()
        print("G: ", gastos)
        energia = modelo.retrieveDataEnergy()
        print("E: ", energia)
        alimentacion = modelo.retrieveDataNutrition()
        print("A: ", alimentacion)
        transporte = modelo.emissionsTransport()
        print("T: ", transporte)
        
        let emisionesTotales = gastos + energia + alimentacion + transporte
        print("TOT: ", emisionesTotales)
        
        let gastos2Display = CGFloat(gastos)
        let energia2Display = CGFloat(energia)
        let alimentacion2Display = CGFloat(alimentacion)
        let transporte2Display = CGFloat(transporte)
        
        let gastos2Text = String(format: "%.2f", gastos / emisionesTotales * 100) + "%"
        let energia2Text = String(format: "%.2f", energia / emisionesTotales * 100) + "%"
        let alimentacion2Text = String(format: "%.2f", alimentacion / emisionesTotales * 100) + "%"
        let transporte2Text = String(format: "%.2f", transporte / emisionesTotales * 100) + "%"
        
        gastosLabel.text = gastos2Text
        energiaLabel.text = energia2Text
        alimentacionLabel.text = alimentacion2Text
        transporteLabel.text = transporte2Text
        
        pieChart.lineWidth = 0.85
        pieChart.addChartData(data: [
            JPieChartDataSet(percent: gastos2Display, colors: [UIColor.babyBlue,UIColor.babyBlue]),
            JPieChartDataSet(percent: energia2Display, colors: [UIColor.greenyBlue,UIColor.greenyBlue]),
            JPieChartDataSet(percent: alimentacion2Display, colors: [UIColor.toronja,UIColor.toronja]),
            JPieChartDataSet(percent: transporte2Display, colors: [UIColor.salmon,UIColor.salmon])
        ])
    }
    
    
    
}


