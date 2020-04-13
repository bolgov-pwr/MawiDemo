//
//  Person.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation
import RealmSwift

final class Measurement: Object {

	let id = RealmOptional<Int>()
	@objc dynamic var date: String?
	let values = List<Int>()
	
	required convenience init(values: [Int]) {
		self.init()
		
		id.value = nextID
		date = MyDateFormatter.shared.getFormatDate(Date())
		for value in values {
			self.values.append(value)
		}
	}
	
	private var nextID: Int {
		let realm = RealmManager.default

		var id = realm.objects(Measurement.self).sorted(byKeyPath: "id", ascending: true).last?.id.value ?? 0
			
		repeat {
			id = id.addingReportingOverflow(1).0
		} while id == 0 || realm.object(ofType: Measurement.self, forPrimaryKey: id) != nil
		
		return id
	}
	
	override static func primaryKey() -> String? {
		return "id"
	}
}
