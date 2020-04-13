//
//  Validator.swift
//  MawiDemo
//
//  Created by Ivan Bolgov on 12.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift

enum Validation: String {
	case none
	case valid
	case invalid
}

final class Validator {
	
	let invalidated = PublishSubject<Void>()
	let validationValues = BehaviorSubject<Validation>(value: .none)
	
	private var validatorSettings = ValidatorSettings()
	private let disposeBag = DisposeBag()
	private var validationCounter = 0
	
	func validation() {
		validationValues
			.subscribe(onNext: { valid in
				
				let prevValue = (try? self.validationValues.value())
				if valid == .invalid && prevValue == .invalid {
					self.validationCounter += 1
				} else {
					self.validationCounter = 0
				}

				if self.validationCounter == self.validatorSettings.validationCount {
					self.invalidated.onNext(())
				}
			})
			.disposed(by: disposeBag)
	}
	
	func validate(_ isValid: Bool) {
		let valid = isValid ? Validation.valid : Validation.invalid
		validationValues.onNext(valid)
	}
}
