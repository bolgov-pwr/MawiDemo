//
//  AppDelegate.swift
//  MawiDemo
//
//  Created by admin on 10.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let measurementVC = MeasurementListViewController()
		let configurator = MeasurementListConfigurator(vc: measurementVC)
		configurator.configure()
		
		let navVC = UINavigationController(rootViewController: measurementVC)
		
		window = UIWindow()
		window?.rootViewController = navVC
		window?.makeKeyAndVisible()
		
		return true
	}
}

