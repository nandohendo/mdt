//
//  LoginResponse.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation

struct LoginResponse: Codable {
	let status: String
	let token: String
	let username: String
	let accountNo: String
}
