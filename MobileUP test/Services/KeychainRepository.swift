//
//  KeychainService.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 23.04.2023.
//

import Foundation

final class KeychainRepository {
    
    private let service = "www.MobileUPTest.com"
    
    static let shared = KeychainRepository()
    
    func saveTokenToKeychain(token: String, key: String) {
        if let data = token.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
            ]
            SecItemDelete(query as CFDictionary)
            let status = SecItemAdd(query as CFDictionary, nil)
            if status == errSecSuccess {
                print("save success")
            }
        }
    }

    func getTokenFromKeychain(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
            print("get success")
            return String(data: retrievedData, encoding: .utf8)
        }
        return nil
    }

    func deleteTokenFromKeychain(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        let status = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess{
            print("delete success")
        }
    }

}
