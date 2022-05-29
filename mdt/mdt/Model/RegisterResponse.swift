//
//  RegisterResponse.swift
//  mdt
//
//  Created by Fernando Prayogo on 29/05/22.
//

import Foundation

struct RegisterResponse: Codable {
	let status: String
	var error: String? = nil
}
