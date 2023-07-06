//
//  HoursCVC.swift
//  AppLifeCiycle
//
//  Created by Alisher on 01/06/23.
//

import UIKit

class HoursCVC: UICollectionViewCell {

    static let id = "HoursCVC"
    static func nib() -> UINib {
       return UINib(nibName: "HoursCVC", bundle: nil)
    }
    
   
    @IBOutlet weak var clockLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var gradusLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var smallContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowOpacity = 0.5
        
        smallContainerView.layer.borderColor = UIColor.gray.cgColor
        smallContainerView.layer.borderWidth = 0.8
        smallContainerView.layer.cornerRadius = UIScreen.main.bounds.width*30/390

    }
    
    func updateCell (date: Hourly) {
        
        let fullData = date.dt_txt
        let fullDataArr = fullData.components(separatedBy: " ")
        let str = fullDataArr[1].replacingOccurrences(of: ":00", with: "")
        
        for i in date.weather {
            weatherImage.image = UIImage(named: i.main)
        }
        clockLbl.text = str+":00"
        gradusLbl.text = "\(Int(date.main.temp-273.15))°C"
        
    }

}
