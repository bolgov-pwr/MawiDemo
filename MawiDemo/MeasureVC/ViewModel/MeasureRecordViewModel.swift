//
//  MeasureRecordViewModel.swift
//  MawiDemo
//
//  Created by Ivan Bolgov on 12.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift
import Charts
import RealmSwift

final class MeasureRecordViewModel: MeasureRecordableVMProtocol {
	var type: MeasureType
	
	let isOpen = PublishSubject<Void>()
	let validText = BehaviorSubject<Validation>(value: Validation.none)
	let disposeBag = DisposeBag()
	
	private let settings = TimerSettings()
	
	private let generator = Generator()
	private var disposeGenerator: Disposable?
	private let scanner = Scanner()
	private let validator = Validator()
	
	private var timer: Timer?
	private var isSave = false
	
	init(type: MeasureType) {
		self.type = type
	}
	
	let entryData = PublishSubject<[Int]>()
	
	func startRecord() {
		if type == .record {
			launchTimer()
		}
		
		disposeGenerator = generator.generate()
			.subscribe(onNext: { values in
				guard values.count > 0 else { return }
				
				self.scanner.scan(values)
				self.entryData.onNext(Array(values.suffix(120)))
			})
		
		scanner.shouldValidate
			.subscribe(onNext: { shouldValidate in
				if shouldValidate {
					self.validator.validate(Bool.random())
				}
			})
			.disposed(by: disposeBag)
		
		validator.validation()
		
		validator.validationValues
			.subscribe(onNext: { state in
				self.validText.onNext(state)
			})
			.disposed(by: disposeBag)
		
		validator.invalidated
			.subscribe(onNext: {
				self.timerFire()
			})
			.disposed(by: disposeBag)
	}
	
	private func launchTimer() {
		timer = Timer(fireAt: Date().addingTimeInterval(settings.fireAt), interval: 0, target: self, selector: #selector(timerFire), userInfo: nil, repeats: false)
		RunLoop.current.add(timer!, forMode: .default)
	}
	
	@objc func timerFire() {
		guard !isSave else { return }
		isSave = true
		
		print("fire")
		timer?.invalidate()
		timer = nil
		disposeGenerator?.dispose()
		isOpen.onNext(())
		isOpen.onCompleted()
		DispatchQueue.main.async {
			let measurement = Measurement(values: self.generator.measurements)
			RealmManager.create(object: measurement)
		}
	}
}
