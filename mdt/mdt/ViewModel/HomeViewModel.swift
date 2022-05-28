//
//  HomeViewModel.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation

final class HomeViewModel {
	
	private let service: RESTService = RESTService()
	var basicInfo: (Double, String)?
	var history: [String?: [TransferDetail]]?
	var sortedDate: [String]?
	var sortedDetail: [[TransferDetail]]?
	
	var onNeedToReloadCollectionView: (() -> Void)?
	var onNeedToReloadBasicInfo: (() -> Void)?
	
	init() {
		getBalance()
		getTransferHistory()
	}
	
	func getBalance() {
		service.makeGetBalanceRequest { [weak self] (isSuccess: Bool, balanceResponse: BalanceResponse?) in
			guard let self = self,
				  isSuccess,
				  let balanceResponse = balanceResponse else {
					  return
				  }
			
			self.basicInfo = (balanceResponse.balance, balanceResponse.accountNo)
			self.onNeedToReloadBasicInfo?()
		}
	}
	
	func getTransferHistory() {
		service.makeGetHistoryRequest { [weak self] (isSuccess: Bool, transferResponse: TransferResponse?) in
			guard let self = self,
					isSuccess,
					let transferResponse = transferResponse else {
				return
			}
			
			let dict = Dictionary(grouping: transferResponse.data) {
				$0.transactionDate.components(separatedBy: "T").first
			}
			
			let sortedArray = dict.sorted( by: { $0.0 ?? "" > $1.0 ?? "" })
			self.sortedDate = sortedArray.map {
				return $0.0 ?? ""
			}
			self.sortedDetail = sortedArray.map {
				return $0.1
			}
						
			self.history = dict
			self.onNeedToReloadCollectionView?()
		}
	}
}
