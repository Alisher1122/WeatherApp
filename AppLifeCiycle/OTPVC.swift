//
//  OTPVC.swift
//  AppLifeCiycle
//
//  Created by Asliddin Mahmudov on 23/07/22.
//

import UIKit
import OTPInputView

class OTPVC: UIViewController {

    @IBOutlet weak var otpView: OTPInputView!
    
    
    //@IBOutlet weak var otp: OTPInputView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  otp.delegateOTP = self
        otpView.delegateOTP = self
        
    }




}


extension OTPVC: OTPViewDelegate {
    
    func didFinishedEnterOTP(otpNumber: String) {
        print("😄 = ",otpNumber)
    }
    
    func otpNotValid() {
        print("otp xato kiritildi")
    }
    
    
}

//extension OTPVC:
