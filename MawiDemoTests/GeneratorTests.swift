//
//  MeasureTests.swift
//  MawiDemoTests
//
//  Created by Ivan Bolgov on 12.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import XCTest
import RxTest
import RxSwift

@testable import MawiDemo

class MeasureTests: XCTestCase {
	
	var disposeBag: DisposeBag!
	
	fileprivate var generator: Generator!
	
	override func setUp() {
		super.setUp()
		self.disposeBag = DisposeBag()
		self.generator = Generator()
	}
	
	override func tearDown() {
		self.generator = nil
		super.tearDown()
	}
	
	func testGenerator() {
		
		let scheduler = TestScheduler(initialClock: 0)
		let values = scheduler.createObserver([Int].self)
		
		var entryData: Disposable?
		
		scheduler.scheduleAt(10) {
			entryData = self.generator.generate().subscribe(values)
		}
		
		scheduler.scheduleAt(500) {
			entryData?.dispose()
		}
		scheduler.start()
		
		let count = values.events.first?.value.element?.count ?? 0
		XCTAssertTrue(count > 0)
	}
	
	func testShouldFire() {
		let scheduler = TestScheduler(initialClock: 0)
		
		var entryData: Disposable?
		
		scheduler.scheduleAt(10) {
			entryData = self.generator.generate().subscribe()
		}
		
		scheduler.scheduleAt(500) {
			entryData?.dispose()
		}
		scheduler.start()
		
		XCTAssertTrue(entryData == nil)
	}
}
