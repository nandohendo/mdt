//
//  MockRESTService.swift
//  mdtTests
//
//  Created by Fernando Prayogo on 28/05/22.
//

import Foundation
@testable import mdt

final class MockRESTService: RESTServiceable {
	var isSuccess: Bool = true
	
	func makeLoginRequest(loginRequest: LoginRequest, completionHandler: @escaping ((Bool) -> Void)) {
		completionHandler(isSuccess)
	}
	
	func makeGetBalanceRequest(completionHandler: @escaping ((Bool, BalanceResponse?) -> Void)) {
		if isSuccess {
			let balanceResponse = BalanceResponse(status: "success", balance: 20, accountNo: "1234-5678-89")
			completionHandler(true, balanceResponse)
		} else {
			completionHandler(false, nil)
		}
	}
	
	func makeGetHistoryRequest(completionHandler: @escaping ((Bool, TransferResponse?) -> Void)) {
		
	}
}
