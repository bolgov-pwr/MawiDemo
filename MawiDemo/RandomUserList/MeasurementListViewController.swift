//
//  ViewController.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MeasurementListViewController: UIViewController {
	
	let tableView: UITableView = {
		let tableView = UITableView(frame: .zero)
		return tableView
	}()
	
	let disposeBag = DisposeBag()
	
	var listVM: MeasurementListViewModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupNavBar()
		setupView()
		setupBindings()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		tableView.frame = view.bounds
	}
	
	private func setupView() {
		title = "List"
		view.addSubview(tableView)
		tableView.backgroundColor = UIColor.white
		tableView.register(MeasurementCell.self, forCellReuseIdentifier: String(describing: MeasurementCell.self))
	}
	
	private func setupNavBar() {
		let button = UIButton()
		button.setTitle("Start new measurement", for: .normal)
		button.setTitleColor(UIColor.blue, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		button.addTarget(self, action: #selector(startNewMeasurementPressed), for: .touchUpInside)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
	}
	
	private func setupBindings() {
		listVM?.loadFromRealm()
		
		listVM?
			.measurements
			.bind(to: tableView.rx.items(cellIdentifier: String(describing: MeasurementCell.self), cellType: MeasurementCell.self)) {  (row, model, cell) in
				cell.setup(with: model)
		}
		.disposed(by: disposeBag)
		
		Observable
			.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Measurement.self))
			.bind { [weak self] indexPath, model in

				let vc = MeasureViewController(values: model.values.map{ $0 })
				self?.navigationController?.pushViewController(vc, animated: true)
			}
			.disposed(by: disposeBag)
		
		tableView
			.rx.delegate
			.setForwardToDelegate(self, retainDelegate: false)
	}
}

extension MeasurementListViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let cellWidth = (collectionView.bounds.width - 4) / 2
		return CGSize(width: cellWidth, height: cellWidth * 1.2)
	}
}
