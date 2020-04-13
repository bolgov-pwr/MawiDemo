//
//  RealmManager.swift
//  MawiDemo
//
//  Created by Ivan Bolgov on 10.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import RealmSwift

final class RealmManager {

	static let `default` = try! Realm(configuration: RealmManager.defaultConfiguration())
	
	static func add<T: Object>(objects: [T], update: Bool = true) {
		do {
			try? RealmManager.default.safeWrite {
				RealmManager.default.add(objects, update: .modified)
			}
		}
	}
	
	static func create<T: Object>(object: T) {
		do {
			try? RealmManager.default.safeWrite {
				RealmManager.default.create(type(of: object), value: object, update: .modified)
			}
		}
	}

	static func create<T: Object>(objects: [T], update: Bool = true) {
		do {
			try? RealmManager.default.safeWrite {
				for object in objects {
					RealmManager.default.create(type(of: object), value: object, update: .modified)
				}
			}
		}
	}

	static func deleteAll() {
		do {
			try RealmManager.default.safeWrite {
				RealmManager.default.deleteAll()
			}
		} catch(let error) {
			print(error.localizedDescription)
		}
	}
	
	static func defaultConfiguration() -> Realm.Configuration {
		let config = Realm.Configuration(schemaVersion: 3, deleteRealmIfMigrationNeeded: true)
		return config
	}
}

extension Realm {
	
	func safeWrite(_ block: (() throws -> Void)) throws {
		if isInWriteTransaction {
			try block()
		} else {
			try write(block)
		}
	}
}
