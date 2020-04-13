//
//  MeasureRecordViewController.swift
//  MawiDemo
//
//  Created by Ivan Bolgov on 13.04.2020.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit
import Charts
import RxSwift

final class MeasureRecordViewController: UIViewController, MeasureViewControllerProtocol  {
	
	var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
	
	init(type: MeasureType) {
		vm = MeasureRecordViewModel(type: type)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let measureView: MeasureView = {
		let view = MeasureView()
		return view
	}()
	
	let disposeBag = DisposeBag()
	var vm: MeasureRecordableVMProtocol
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureView()
		setupBindings()
		NotificationCenter.default.addObserver(self, selector: #selector(myObserverMethod(notification:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		measureView.frame = view.bounds
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		stopButtonPressed()
	}
	
	private func configureView() {
		view.backgroundColor = .white
		view.addSubview(measureView)
		
		switch vm.type {
		case .record, .recordEndless:
			measureView.stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
		}
	}
	
	private func setupBindings() {

		vm.isOpen
			.subscribe(onNext: {
					DispatchQueue.main.async {
						self.navigationController?.popViewController(animated: true)
					}
			})
			.disposed(by: disposeBag)
		
		vm.validText.asObservable()
			.map { $0.rawValue }
			.bind(to: self.measureView.validLabel.rx.text)
			.disposed(by: disposeBag)
		
		vm.entryData
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { dataSets in
				
				let set = LineChartDataSet(entries: dataSets.enumerated().map { ChartDataEntry(x: Double($0.offset), y: Double($0.element)) })
				set.drawCirclesEnabled = false
				self.measureView.chartView.data = LineChartData(dataSet: set)
				self.measureView.chartView.notifyDataSetChanged()
			})
			.disposed(by: disposeBag)
		
		vm.startRecord()
	}
	
	@objc private func stopButtonPressed() {
		vm.timerFire()
	}
}

