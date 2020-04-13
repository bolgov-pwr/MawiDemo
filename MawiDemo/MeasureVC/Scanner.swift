//
//  Scanner.swift
//  MawiDemo
//
//  Created by Ivan Bolgov on 12.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift

final class Scanner {
	
	private let disposeBag = DisposeBag()
	private var scanSettings = ScanSettngs()
	
	var shouldValidate = PublishSubject<Bool>()
	
	func scan(_ values: [Int]) {
		guard values.count > self.scanSettings.offset else { return }
		let firstIndex = self.scanSettings.checkingCount * self.scanSettings.offsetStep
		let lastIndex = self.scanSettings.offset
		print(values.count)
		print("from \(firstIndex) to \(lastIndex)")
		shouldValidate.onNext(true)
		scanSettings.nextStep()
	}
}
