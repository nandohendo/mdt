//
//  PayeeResponse.swift
//  mdt
//
//  Created by Fernando Prayogo on 28/05/22.
//

import Foundation

struct PayeeResponse: Codable {
	let status: String
	let data: [PayeeDetail]
}

struct PayeeDetail: Codable {
	let id: String
	let name: String
	let accountNo: String
}
