//
//  DPKeychain.swift
//  DPUniqueId
//
//  Created by developeng on 2024/11/8.
//

import UIKit
import Security

// 将信息存入Keychain中，用户卸载应用信息不丢失
class DPKeychain {
    // 将字符串值保存到Keychain中。
    static func saveToKeychain(_ value: String, service: String, account: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        // 删除旧的数据
        SecItemDelete(query(service: service, account: account) as CFDictionary)
        
        // 添加新的数据
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ] as [String: Any]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    // 从Keychain中加载字符串值
    static func loadFromKeychain(service: String, account: String) -> String? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String: Any]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess, let data = item as? Data {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    // 从Keychain中删除指定的服务和账户的数据。
    static func deleteFromKeychain(service: String, account: String) -> Bool {
        let query = query(service: service, account: account)
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    private static func query(service: String, account: String) -> [String: Any] {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
    }
    
    
}
