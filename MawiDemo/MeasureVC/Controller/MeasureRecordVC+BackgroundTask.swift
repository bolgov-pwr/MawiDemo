//
//  MeasureRecordVC+BackgroundTask.swift
//  MawiDemo
//
//  Created by Ivan Bolgov on 13.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit

extension MeasureRecordViewController {
	
	func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
		assert(backgroundTask != UIBackgroundTaskIdentifier.invalid)
    }
    
    func endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
		backgroundTask = UIBackgroundTaskIdentifier.invalid
    }
	
	@objc func myObserverMethod(notification : NSNotification) {
		registerBackgroundTask()
	}
}
