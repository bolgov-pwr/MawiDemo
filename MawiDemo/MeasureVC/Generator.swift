//
//  Generator.swift
//  MawiDemo
//
//  Created by Ivan Bolgov on 10.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift

final class Generator {
	
	let disposeBag = DisposeBag()

	var measurements: [Int] {
		return (try? values.value()) ?? []
	}
	
	private var generatorSettings = GeneratorSettings()
	private var values = BehaviorSubject(value: [Int]())
	
	func generate() -> Observable<[Int]> {
		
		return Observable<Int>
			.interval(RxTimeInterval.milliseconds(generatorSettings.delay), scheduler: ConcurrentDispatchQueueScheduler.init(qos: .background))
			.observeOn(MainScheduler.instance)
			.flatMap { _ in
				return self.randomValues()
			}
	}
	
	private func randomValues() -> Observable<[Int]> {
		print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
		var newValues = [Int]()
		for _ in 0..<generatorSettings.valuesInTact {
			newValues.append(Int.random(in: generatorSettings.minValue..<generatorSettings.maxValue))
		}

		let prevValues = (try? self.values.value()) ?? []
		self.values.onNext(prevValues + newValues)
		return self.values.asObservable()
	}
}
