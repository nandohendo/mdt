//
//  BalanceResponse.swift
//  mdt
//
//  Created by Fernando Prayogo on 28/05/22.
//

import Foundation

struct BalanceResponse: Codable {
	let status: String
	let balance: Double
	let accountNo: String
}
