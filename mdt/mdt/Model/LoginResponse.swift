//
//  LoginResponse.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation

struct LoginResponse: Codable {
	let status: String
	var token: String? = nil
	var username: String? = nil
	var accountNo: String? = nil
	var error: String? = nil
}
