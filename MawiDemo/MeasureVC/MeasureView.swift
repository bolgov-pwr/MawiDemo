//
//  MeasureView.swift
//  MawiDemo
//
//  Created by Ivan Bolgov on 10.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit
import Charts

final class MeasureView: UIView {
	
	let chartView: LineChartView = {
		let chart = LineChartView()
		
		chart.xAxis.drawGridLinesEnabled = false
		chart.xAxis.avoidFirstLastClippingEnabled = true

		chart.rightAxis.drawAxisLineEnabled = false
		chart.rightAxis.drawLabelsEnabled = false
		
		chart.scaleYEnabled = false
		chart.leftAxis.drawAxisLineEnabled = false
		chart.pinchZoomEnabled = false
		chart.doubleTapToZoomEnabled = false
		chart.legend.enabled = false
		
		chart.translatesAutoresizingMaskIntoConstraints = false
		return chart
	}()
	
	let validLabel: UILabel = {
		let lbl = UILabel()
		lbl.text = "Valid"
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	
	let stopButton: UIButton = {
		let btn = UIButton()
		btn.layer.cornerRadius = 5
		btn.setTitle("Stop", for: .normal)
		btn.setTitleColor(UIColor.black, for: .normal)
		btn.backgroundColor = UIColor.red.withAlphaComponent(0.9)
		btn.translatesAutoresizingMaskIntoConstraints = false
		return btn
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = UIColor.white
		
		[chartView, validLabel, stopButton].forEach { addSubview($0) }
		NSLayoutConstraint.activate([
			chartView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
			chartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
			chartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
			chartView.bottomAnchor.constraint(equalTo: validLabel.topAnchor, constant: -16),
			
			validLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			validLabel.bottomAnchor.constraint(equalTo: stopButton.topAnchor, constant: -16),
			
			stopButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			stopButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
			stopButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}
}
