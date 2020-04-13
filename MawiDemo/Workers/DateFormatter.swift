//
//  DateFormatter.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/12/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import Foundation

final class MyDateFormatter {
	
	static let shared = MyDateFormatter()
	
	private let dateFormatter: DateFormatter
	
	private init() {
		dateFormatter = DateFormatter()
	}
	
	func getFormatDate(_ date: Date, format: String? = nil) -> String {
		dateFormatter.dateFormat = format ?? "MM-dd HH:mm"
		dateFormatter.locale = Locale(identifier: "en")
		return dateFormatter.string(from: date)
	}
}
