//
//  MeasureViewController.swift
//  MawiDemo
//
//  Created by Ivan Bolgov on 10.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit
import Charts
import RxSwift

protocol MeasureViewControllerProtocol {
	var measureView: MeasureView { get }
}

final class MeasureViewController: UIViewController, MeasureViewControllerProtocol {
	
	private var values = [Int]()
	
	init(values: [Int]) {
		super.init(nibName: nil, bundle: nil)
		self.values = values
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let measureView: MeasureView = {
		let view = MeasureView()
		return view
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureView()
		setupBindings()
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		measureView.frame = view.bounds
	}
	
	private func configureView() {
		view.backgroundColor = .white
		view.addSubview(measureView)
		
		measureView.stopButton.isHidden = true
		measureView.validLabel.isHidden = true
	}
	
	private func setupBindings() {
		let set = LineChartDataSet(entries: values.enumerated().map { ChartDataEntry(x: Double($0.offset), y: Double($0.element)) })
		set.drawCirclesEnabled = false
		self.measureView.chartView.data = LineChartData(dataSet: set)
	}
}
