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
	
	func makeLoginRequest(loginRequest: LoginRequest, completionHandler: @escaping ((Bool, String?) -> Void)) {
		if isSuccess {
			completionHandler(true, nil)
		} else {
			completionHandler(false, "invalid login credential")
		}
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
		if isSuccess {
			let data1 = TransferDetail(amount: 20, transactionDate: "2022-03-11T15:13:58.927Z", receipient: TransferRecipient(accountNo: "2020", accountHolder: "ABCD"), transactionType: "transfer")
			let data2 = TransferDetail(amount: 20, transactionDate: "2022-03-12T15:13:58.927Z", receipient: TransferRecipient(accountNo: "2020", accountHolder: "ABCD"), transactionType: "transfer")
			let transferResponse = TransferResponse(status: "success", data: [data1, data2])
			completionHandler(true, transferResponse)
		} else {
			completionHandler(false, nil)
		}
	}
	
	func makeRegisterRequest(registerRequest: RegisterRequest, completionHandler: @escaping ((Bool, String?) -> Void)) {
		if isSuccess {
			completionHandler(true, nil)
		} else {
			completionHandler(false, "account already exists")
		}
	}
}
