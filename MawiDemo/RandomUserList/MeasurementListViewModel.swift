//
//  RandomUserViewModel.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class MeasurementListViewModel {
	
	
	required init() {
	}
	var realmNotificationToken: NotificationToken?
	let disposeBag = DisposeBag()
	
	public let measurements: BehaviorSubject<[Measurement]> = BehaviorSubject(value: [])
	
	func loadFromRealm() {
		realmObserver()
	}
	
	private func realmObserver() {
	
		realmNotificationToken = RealmManager.default.objects(Measurement.self).observe({ [weak self] changes in
			switch changes {
			case .initial(let measures):
				print(measures.count)
				self?.measurements.onNext(measures.compactMap { $0 })
			case .update(let measures):
				self?.measurements.onNext(measures.0.compactMap { $0 })
			case .error(let err):
				print(err.localizedDescription)
			}
		})
	}
}
