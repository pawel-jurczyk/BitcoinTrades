//
//  AppDelegate.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 21/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TradesTableViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
