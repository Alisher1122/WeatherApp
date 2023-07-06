//
//  AppDelegate.swift
//  AppLifeCiycle
//
//  Created by Asliddin Mahmudov on 21/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("didFinishLaunchingWithOptions")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = TabBar() //-> custom tabbar

        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
    

}

