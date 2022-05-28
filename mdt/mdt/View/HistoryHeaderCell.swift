//
//  HistoryHeaderCell.swift
//  mdt
//
//  Created by Fernando Prayogo on 28/05/22.
//

import Foundation
import UIKit

final class HistoryHeaderCell: UICollectionReusableView {
	
	var transactionDate: String? {
		didSet {
			transactionDateLabel.text = transactionDate
		}
	}
	
	private let transactionDateLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)		
		addViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
	}
	
	private func addViews() {
		transactionDateLabel.frame = CGRect(x: 16, y: 16, width: self.bounds.width - 32, height: 28)
		transactionDateLabel.textAlignment = .left
		transactionDateLabel.textColor = .darkGray
		transactionDateLabel.font = .systemFont(ofSize: 20)
		
		addSubview(transactionDateLabel)
	}
}
