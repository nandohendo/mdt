//
//  MockKeychainHelper.swift
//  mdtTests
//
//  Created by Fernando Prayogo on 29/05/22.
//

import Foundation
@testable import mdt

final class MockKeychainHelper: KeychainHelperable {
	static var isCacheCalled = false
	static var isRemoveAllValuesCalled = false
	
	static func cache(value: String, for key: KeychainHelper.Key) {
		isCacheCalled = true
	}
	
	static func value(for key: KeychainHelper.Key) -> String? {
		return "mockedValue"
	}
	
	static func removeValue(for key: KeychainHelper.Key) {
		
	}
	
	static func removeAllValues() {
		isRemoveAllValuesCalled = true
	}
}
