//
//  CitiesTableVIewCell.swift
//  AppLifeCiycle
//
//  Created by Alisher on 08/06/23.
//

import UIKit

class CitiesTableVIewCell: UITableViewCell {

    static let identifier: String = "CitiesTableVIewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CitiesTableVIewCell", bundle: nil)
    }
      
    
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.layer.borderWidth = 1
            containerView.layer.cornerRadius = 10
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func updateCell(name: String) {
        cityNameLbl.text = name
    }
    
}
