//
//  DPUser.swift
//  DPUniqueId
//
//  Created by developeng on 2024/11/8.
//

import UIKit

// keychainService = com.yourcompany.yourapp
let keychainService = "com.wh.b"
let keychainAccount = "uniqueIdentifier"

class DPUser {
    
    // 获取iOS设备唯一标识
   static func getUniqueIdentifier() -> String {
        // 检查Keychain中是否已有UUID，如果有则返回，否则生成新的UUID并保存到Keychain中。
        if let identifier = DPKeychain.loadFromKeychain(service: keychainService, account: keychainAccount) {
            return identifier
        } else {
            let newIdentifier = UUID().uuidString
            let success = DPKeychain.saveToKeychain(newIdentifier, service: keychainService, account: keychainAccount)
            if !success {
                print("Failed to save unique identifier to Keychain")
            }
            return newIdentifier
        }
    }
}
