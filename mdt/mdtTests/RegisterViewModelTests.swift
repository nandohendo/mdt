//
//  RegisterViewModelTests.swift
//  mdtTests
//
//  Created by Fernando Prayogo on 29/05/22.
//

import Foundation
import Quick
import Nimble

@testable import mdt

final class RegisterViewModelTests: QuickSpec {
	
	override func spec() {
		var viewModel: RegisterViewModel!
		var mockRESTService: MockRESTService!
		
		beforeEach {
			viewModel = RegisterViewModel()
			mockRESTService = MockRESTService()
			viewModel.service = mockRESTService
		}
		
		describe("handle register tapped") {
			context("API request is success") {
				it("onNeedToShowHome is triggered") {
					var isRegisterSuccess = false
					mockRESTService.isSuccess = true
					
					viewModel.onNeedToShowRegisterSuccess = {
						isRegisterSuccess = true
					}
					viewModel.handleRegisterTapped(username: "a", password: "b")
					expect(isRegisterSuccess).to(beTrue())
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
					viewModel.handleRegisterTapped(username: "a", password: "b")
					expect(isShowAlertCalled).to(beTrue())
					expect(errorMessageTemp).to(equal("account already exists"))
				}
			}
		}
		
		describe("handle back tapped") {
			it("should call onNeedToDismissViewController") {
				var isDismissCalled = false
				viewModel.onNeedToDismissViewController = {
					isDismissCalled = true
				}
				
				viewModel.handleBackTapped()
				expect(isDismissCalled).to(beTrue())
			}
		}
	}
}
