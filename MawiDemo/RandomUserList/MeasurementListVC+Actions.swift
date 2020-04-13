//
//  RandomUserVC+Actions.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit

extension MeasurementListViewController {

	@objc func startNewMeasurementPressed() {
		showRecordAlert()
	}
	
	private func showRecordAlert() {
		let alert = UIAlertController(title: "Select measurement type", message: "", preferredStyle: .alert)
		let recordAction = UIAlertAction(title: "Record 5 mins", style: .default) { [weak self] _ in
			self?.startMeasurement(type: .record)
		}
		let recordEndlessAction = UIAlertAction(title: "Record endless", style: .default) { [weak self] _ in
			self?.startMeasurement(type: .recordEndless)
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
		
		[recordAction, recordEndlessAction, cancelAction].forEach { alert.addAction($0) }
		present(alert, animated: true, completion: nil)
	}
	
	private func startMeasurement(type: MeasureType) {
		let vc = MeasureRecordViewController(type: type)
		DispatchQueue.main.async {
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
}
