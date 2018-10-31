//
//  ViewController.swift
//  centrum
//
//  Created by ip on 10/23/18.
//  Copyright © 2018 puri inc. All rights reserved.
//

import UIKit
import BarcodeScanner

class MainVC: UIViewController {

    @IBOutlet weak var scanBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleScanPresent(_ sender: Any) {
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "ID Scanner"
        present(viewController, animated: true, completion: nil)
    }
    
    
    private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        return viewController
    }
    
    private func evaluateID(idValue:String, _ controller: BarcodeScannerViewController){
        controller.dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: "\(idValue)", message: "😁", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - BarcodeScannerCodeDelegate
extension MainVC: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code:String, type: String) {
        print("\nID received: \(code)")
        print("Symbology Type: \(type)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            controller.resetWithError()
        }
        evaluateID(idValue: code, controller)
    }
}
    
// MARK: - BarcodeScannerErrorDelegate
extension MainVC: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}
    
// MARK: - BarcodeScannerDismissalDelegate
extension MainVC: BarcodeScannerDismissalDelegate {
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

