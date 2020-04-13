//
//  Protocols.swift
//  MawiDemo
//
//  Created by Ivan Bolgov on 12.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift
import Charts

protocol MeasureVMProtocol {
	var entryData: PublishSubject<[Int]> { get }
}

protocol  MeasureRecordableVMProtocol: MeasureVMProtocol {
	var type: MeasureType { get set }
	var isOpen: PublishSubject<Void> { get }
	var validText: BehaviorSubject<Validation> { get }
	
	func startRecord()
	func timerFire()
}
