//
//  HistoryCell.swift
//  mdt
//
//  Created by Fernando Prayogo on 28/05/22.
//

import Foundation
import UIKit

final class HistoryCell: UICollectionViewCell {
	
	private let recipientNameLabel = UILabel()
	private let recipientAccountNumberLabel = UILabel()
	private let balanceChangeLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addViews() {
		backgroundColor = .white
		createRecipientLabel()
		createBalanceChangeLabel()
	}
	
	private func createRecipientLabel() {
		recipientNameLabel.frame = CGRect(x: 0, y: 0, width: Device.screenWidth * 0.55, height: 28)
		recipientNameLabel.textAlignment = .left
		recipientNameLabel.font = .systemFont(ofSize: 16)
		recipientNameLabel.text = "Jackie"
		
		recipientAccountNumberLabel.frame = CGRect(x: 0, y: 36, width: Device.screenWidth * 0.55, height: 28)
		recipientAccountNumberLabel.textAlignment = .left
		recipientAccountNumberLabel.font = .systemFont(ofSize: 16)
		recipientAccountNumberLabel.text = "2324-000-124"
		
		addSubview(recipientNameLabel)
		addSubview(recipientAccountNumberLabel)
	}
	
	private func createBalanceChangeLabel() {
		balanceChangeLabel.frame = CGRect(x: Device.screenWidth * 0.6, y: 18, width: ((Device.screenWidth * 0.35) - 16), height: 28)
		balanceChangeLabel.clipsToBounds = true
		balanceChangeLabel.textAlignment = .right
		balanceChangeLabel.font = .systemFont(ofSize: 16)
		balanceChangeLabel.text = "1,234.0"
		
		addSubview(balanceChangeLabel)
	}
	
}
