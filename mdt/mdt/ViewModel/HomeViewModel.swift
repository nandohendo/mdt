//
//  HomeViewModel.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation

final class HomeViewModel {
	
	private let service: RESTService = RESTService()
	
	init() {
		getBalance()
	}
	
	func getBalance() {
		service.makeGetBalanceRequest { (isSuccess: Bool) in
			
		}
	}
}
