//
//  LoginViewModel.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation

final class LoginViewModel {
	
	var onNeedToShowHome: (() -> Void)?
	private let service: RESTService = RESTService()
	
	func handleLoginTapped(username: String, password: String) {
		let loginRequest = LoginRequest(username: "test", password: "asdasd")
		service.makeLoginRequest(loginRequest: loginRequest) { [weak self] (isLoginSuccess: Bool) in
			if isLoginSuccess {
				self?.onNeedToShowHome?()
			} else {
				// show error
			}
		}
	}
}
