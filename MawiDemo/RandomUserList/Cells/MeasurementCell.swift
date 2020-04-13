//
//  PersonCell.swift
//  RandomUserDemo
//
//  Created by Ivan Bolgov on 3/11/20.
//  Copyright © 2020 Ivan Bolgov. All rights reserved.
//

import UIKit
import RxSwift

final class MeasurementCell: UITableViewCell {

	private let titleLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	
	private let dateLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	
	var disposeBag = DisposeBag()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		selectionStyle = .none
		[titleLabel, dateLabel].forEach { addSubview($0) }
		NSLayoutConstraint.activate([
			titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
			titleLabel.widthAnchor.constraint(equalTo: dateLabel.widthAnchor, multiplier: 1)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		titleLabel.text = ""
		dateLabel.text = ""

		disposeBag = DisposeBag()
	}

	func setup(with measure: Measurement) {
		titleLabel.text = "\(measure.id.value ?? 0)"
		dateLabel.text = measure.date
	}
}
