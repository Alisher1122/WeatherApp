//
//  MainVC.swift
//  AppLifeCiycle
//
//  Created by Asliddin Mahmudov on 21/07/22.
//

import UIKit

class MainVC: UIViewController {

    
    @IBOutlet weak var containerVIew: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        containerVIew.applyGradient(colors: [UIColor(named: "Color2")!,UIColor(named:"Color1")!])
        view.applyGradient(colors: [UIColor(named: "Color2")!,UIColor(named:"Color1")!])
        
    }


    

}


extension UIView {
    func applyGradient(colors: [UIColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
