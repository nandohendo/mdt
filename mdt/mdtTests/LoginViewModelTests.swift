//
//  LoginViewModelTests.swift
//  mdtTests
//
//  Created by Fernando Prayogo on 28/05/22.
//

import Foundation
import Quick
import Nimble

@testable import mdt

final class LoginViewModelTests: QuickSpec {
	
	override func spec() {
		var viewModel: LoginViewModel!
		var mockRESTService: MockRESTService!
		
		beforeEach {
			viewModel = LoginViewModel()
			mockRESTService = MockRESTService()
			viewModel.service = mockRESTService
		}
		
		describe("handle login tapped") {
			context("API request is success") {
				it("onNeedToShowHome is triggered") {
					var isShowHomeCalled = false
					mockRESTService.isSuccess = true
					
					viewModel.onNeedToShowHome = {
						isShowHomeCalled = true
					}
					viewModel.handleLoginTapped(username: "a", password: "b")
					expect(isShowHomeCalled).to(beTrue())
				}
			}
			
			context("API request is failed") {
				it("onNeedToShowHome is triggered") {
					var isShowAlertCalled = false
					var errorMessageTemp: String? = ""
					mockRESTService.isSuccess = false
					
					viewModel.onNeedToShowErrorAlert = { (errorMessage: String?) in
						isShowAlertCalled = true
						errorMessageTemp = errorMessage
					}
					viewModel.handleLoginTapped(username: "a", password: "b")
					expect(isShowAlertCalled).to(beTrue())
					expect(errorMessageTemp).to(equal("invalid login credential"))
				}
			}
		}
		
		describe("handle register tapped") {
			it("should call onNeedToShowRegister") {
				var isShowRegisterCalled = false
				viewModel.onNeedToShowRegister = {
					isShowRegisterCalled = true
				}
				
				viewModel.handleRegisterTapped()
				expect(isShowRegisterCalled).to(beTrue())
			}
		}
	}
}
