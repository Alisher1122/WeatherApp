//
//  TabBar.swift
//  AppLifeCiycle
//
//  Created by Asliddin Mahmudov on 22/07/22.
//

import UIKit
import SnapKit

class TabBar: UITabBarController {

    var containerView = UIView(
        frame: CGRect(
            x: 0,
            y: UIScreen.main.bounds.height - UIScreen.main.bounds.width*90/390,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.width*90/390
        )
    )
    
    var btnStack = UIStackView(
        frame: CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width*310/390,
            height: 65)
    )
    
    let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    let plusBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        setUpUI()
        self.view.backgroundColor = .white
        let left = LeftVC(nibName: "LeftVC", bundle: nil)
        let main = MainVC(nibName: "MainVC", bundle: nil)
        let right = RightVC(nibName: "RightVC", bundle: nil)
        viewControllers = [
            left,
            UINavigationController(rootViewController: main),
            UINavigationController(rootViewController: right)
        ]
        
    }
    
    func setUpUI() {
        
        let bigImage = UIImageView(frame: view.frame)
        bigImage.image = UIImage(named: "big")
        
        let ellipsImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*258/390, height: UIScreen.main.bounds.width*160/300))
        ellipsImage.image = UIImage(named: "round")
        
        plusBtn.tintColor = .white
        plusBtn.setImage(UIImage(named: "plus2"), for: .normal)
        
      //  leftBtn.tintColor = .tintColor
        leftBtn.setImage(UIImage(named: "location"), for: .normal)
        
        
        rightBtn.tintColor = .white
        rightBtn.setImage(UIImage(named: "table"), for: .normal)
        
        view.addSubview(containerView)
        //----------------
        containerView.addSubview(bigImage)
        bigImage.snp.makeConstraints { make in
            make.top.bottom.equalTo(containerView).inset(0)
            make.left.right.equalTo(containerView).inset(0)
        }
        //----------------
        containerView.addSubview(ellipsImage)
        ellipsImage.snp.makeConstraints { make in
            make.top.bottom.equalTo(containerView).inset(0)
            make.left.right.equalTo(containerView).inset(UIScreen.main.bounds.width*66/390)
        }

        btnStack.axis = .horizontal
        btnStack.contentMode = .scaleToFill
        btnStack.alignment = .fill
        btnStack.distribution = .fillEqually
        btnStack.spacing = (UIScreen.main.bounds.width*1.1)/2
        containerView.addSubview(btnStack)
       
      
        btnStack.snp.makeConstraints { make in
            make.left.right.equalTo(containerView).inset(UIScreen.main.bounds.width*40/390)
            make.top.equalTo(containerView).inset(5)
            make.bottom.equalTo(containerView).inset(5)
        }
        
        containerView.addSubview(plusBtn)
        plusBtn.snp.makeConstraints { make in
            make.top.bottom.equalTo(containerView).inset(0)
            make.left.right.equalTo(containerView).inset(UIScreen.main.bounds.width*150/390)
        }
        
        btnStack.addArrangedSubview(leftBtn)
        btnStack.addArrangedSubview(rightBtn)
       
        //MARK: - For test buttons and stack -
      //  btnStack.backgroundColor = .red
      //  containerView.backgroundColor = .black
       // plusBtn.backgroundColor = .yellow
      //  leftBtn.backgroundColor = .blue
      //  rightBtn.backgroundColor = .green

        plusBtn.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        leftBtn.addTarget(self, action: #selector(leftTapped), for: .touchUpInside)
        rightBtn.addTarget(self, action: #selector(rightTapped), for: .touchUpInside)
    }
      
    
    @objc func leftTapped() {
        print("left")
        selectedIndex = 0
        rightBtn.tintColor = .white
    }
    
    @objc func plusTapped() {
        print("plus")
        selectedIndex = 1
        leftBtn.tintColor = .white
        rightBtn.tintColor = .white
    }
    
    @objc func rightTapped() {
        print("right")
        selectedIndex = 2
        leftBtn.tintColor = .white
    }
    


}
