//
//  ScanSettings.swift
//  MawiDemo
//
//  Created by Ivan Bolgov on 12.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation

struct ScanSettngs {
	
	let scanWindow: Int = 1000
	let offsetStep: Int = 250
	
	var checkingCount: Int = 0
	
	mutating func nextStep() {
		checkingCount += 1
	}
	
	var offset: Int {
		return scanWindow + (checkingCount * offsetStep)
	}
}
