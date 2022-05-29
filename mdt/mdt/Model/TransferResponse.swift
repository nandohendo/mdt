//
//  TransferResponse.swift
//  mdt
//
//  Created by Fernando Prayogo on 28/05/22.
//

import Foundation

struct TransferResponse: Codable {
	let status: String
	let data: [TransferDetail]
}

struct TransferDetail: Codable {
	let amount: Double
	let transactionDate: String
	var receipient: TransferRecipient? = nil
	let transactionType: String
	var sender: Sender? = nil
}

struct TransferRecipient: Codable {
	let accountNo: String
	let accountHolder: String
}

struct Sender: Codable {
	let accountNo: String
	let accountHolder: String
}
