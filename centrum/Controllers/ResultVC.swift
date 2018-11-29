//
//  ScanVC.swift
//  centrum
//
//  Created by ip on 10/27/18.
//  Copyright © 2018 puri inc. All rights reserved.
//

import UIKit
import Firebase

class ResultVC: UIViewController {

    @IBOutlet weak var psswdTxt: UITextField!
    @IBOutlet weak var queryTxt: UITextField!
    @IBOutlet weak var outputTxtView: UITextView!
    @IBOutlet weak var goBtn: UIButton!
    
    var ref: DatabaseReference!
    var databaseHandle:DatabaseHandle?
    
    let password = "whoa"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Result"
        
        //set firebase reference
        ref = Database.database().reference()
        
    }
    
    @IBAction func goPressed(_ sender: Any) {
        if(psswdTxt.text=="\(password)"){
            //retrieve data and listen for changes
            ref?.child("wbAttendees").child(queryTxt.text!).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let wbTicket = value?["wbTicketStatus"] as? String ?? "nil"
                let asb = value?["ASB"] as? Bool ?? nil
                
                self.ref?.child("studentData").child(self.queryTxt.text!).observeSingleEvent(of: .value, with: { (snapshot2) in
                    let value2 = snapshot2.value as? NSDictionary
                    let firstName = value2?["firstName"] as? String ?? "nil"
                    let lastName = value2?["lastName"] as? String ?? "nil"
                    let grade = value2?["grade"] as? Int
                    
                    //safely check for nil values
                    var gradeStr: String
                    if(grade==nil){
                        gradeStr = "nil"
                    }else{
                        gradeStr = "\(grade!)"
                    }
                    var asbStr: String
                    if(asb==nil){
                        asbStr = "nil"
                    }else{
                        asbStr = "\(asb!)"
                    }

                    
                    self.outputTxtView.text = "name = \(firstName) \(lastName)\nWB Ticket Status = \(wbTicket)\nASB? = \(asbStr)\ngrade = \(gradeStr) \nid = \(self.queryTxt.text!)"
                })

            }) { (error) in
                print(error.localizedDescription)
            }
        }else{
            
        }
    }
    

}
