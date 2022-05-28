//
//  KeychainHelper.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation
import KeychainSwift

final class KeychainHelper {
	
	enum Key: CaseIterable {
		case token
		case username
	}
		
	private static let keychain: KeychainSwift = KeychainSwift()
	
}

extension KeychainHelper {
	static func cache(value: String, for key: KeychainHelper.Key) {
		let keyString = string(for: key)
		keychain.set(value, forKey: keyString, withAccess: .accessibleAfterFirstUnlockThisDeviceOnly)
	}
	
	static func value(for key: KeychainHelper.Key) -> String? {
		let keyString = string(for: key)
		return keychain.get(keyString)
	}
	
	static func removeValue(for key: KeychainHelper.Key) {
		let keyString = string(for: key)
		keychain.delete(keyString)
	}
	
	static func removeAllValues() {
		Key.allCases.forEach { (key) in
			removeValue(for: key)
		}
	}
	
	private static func string(for key: Key) -> String {
		
		switch key {
		case .token:
			return "mdt-token"
		case .username:
			return "mdt-username"
		}
	}
}
