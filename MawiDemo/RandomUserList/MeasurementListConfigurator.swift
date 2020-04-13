//
//  RandomUserConfigurator.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit

final class MeasurementListConfigurator {
	
	let vc: MeasurementListViewController
	
	init(vc: MeasurementListViewController) {
		self.vc = vc
	}
	
	func configure() {
		let vm = MeasurementListViewModel()
		vc.listVM = vm
	}
}
