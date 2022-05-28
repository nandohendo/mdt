//
//  HomeViewModelTests.swift
//  mdtTests
//
//  Created by Fernando Prayogo on 29/05/22.
//

import Foundation
import Quick
import Nimble

@testable import mdt

final class HomeViewModelTests: QuickSpec {

	override func spec() {
		var viewModel: HomeViewModel!
		var mockRESTService: MockRESTService!
		
		beforeEach {
			mockRESTService = MockRESTService()
			viewModel = HomeViewModel(service: mockRESTService)
		}
		
		afterEach {
			viewModel = nil
		}
		
		describe("get balance API") {
			context("API request is success") {
				it("should return balance and execute onNeedToReloadBasicInfo") {
					var isReloadBasicInfoCalled = false
					mockRESTService.isSuccess = true

					viewModel.onNeedToReloadBasicInfo = {
						isReloadBasicInfoCalled = true
					}
					
					viewModel.getBalance()
					expect(viewModel.basicInfo).to(equal((20, "1234-5678-89")))
					expect(isReloadBasicInfoCalled).to(beTrue())
				}
			}
			
			context("API request is failed") {
				it("should not return balance and not execute onNeedToReloadBasicInfo") {
					var isReloadBasicInfoCalled = false
					mockRESTService.isSuccess = false
					
					viewModel.onNeedToReloadBasicInfo = {
						isReloadBasicInfoCalled = true
					}
					
					viewModel.getBalance()
					expect(viewModel.basicInfo).to(beNil())
					expect(isReloadBasicInfoCalled).to(beFalse())
				}
			}
		}
		
		describe("get transaction history API") {
			context("API request is success") {
				it("should return history and execute onNeedToReloadCollectionView") {
					var isReloadCollectionView = false
					mockRESTService.isSuccess = true

					viewModel.onNeedToReloadCollectionView = {
						isReloadCollectionView = true
					}
					
					viewModel.getTransferHistory()
					expect(viewModel.sortedDate?[0]).to(equal("2022-03-12"))
					expect(isReloadCollectionView).to(beTrue())
				}
			}
			
			context("API request is failed") {
				it("should not return history and not execute onNeedToReloadCollectionView") {
					var isReloadCollectionView = false
					mockRESTService.isSuccess = false
					
					viewModel.onNeedToReloadBasicInfo = {
						isReloadCollectionView = true
					}
					
					viewModel.getTransferHistory()
					expect(viewModel.sortedDate).to(beNil())
					expect(isReloadCollectionView).to(beFalse())
				}
			}
		}
	}
}
