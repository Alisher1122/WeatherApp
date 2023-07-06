//
//  RegisterVC.swift
//  AppLifeCiycle
//
//  Created by Asliddin Mahmudov on 23/07/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterVC: UIViewController {

    @IBOutlet weak var numberTf: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func nextTapped(_ sender: Any) {
        
        if Reachability.isConnectedToNetwork() {
            
            
            let params: [String: Any] = [
                "phone_number": Int(numberTf.text ?? "0") ?? 0,
                "status": "registration",
                "type": "student"
            ]
            
            let header: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            AF.request("https://api.birzoom.uz:5000/v1/auth", method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).response { response in
                

                
                
                
                if let data = response.data {
                    
                    print("😄 = ",JSON(data))
                    
                    
                    let jsonData = JSON(data)
                    
                    if jsonData["status"] == "sms_sent" {
//                      go otp
                    } else if jsonData["status"] == "sms_sent_before" {
//                        show alert
                    }
                    
                }
                
            }

            
        } else {
            print("not connection")
//                      show alert
        }
        
        
    }
    

}
