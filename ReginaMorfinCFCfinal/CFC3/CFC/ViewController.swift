//
//  ViewController.swift
//  CFC
//
//  Created by Regina on 08/04/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showPrivacyNotice(_ sender: Any) {
        showAlert(title: "Aviso de Privacidad", message: "La información proporcionada no se guardará en nuestro sistema. Aplicación sin fines de lucro.")
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("UIAllert Done")
        }))
        self.present(alert, animated: true, completion: nil)
    }


}

