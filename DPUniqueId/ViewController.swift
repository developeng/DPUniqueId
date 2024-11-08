//
//  ViewController.swift
//  DPUniqueId
//
//  Created by developeng on 2024/11/8.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 获取唯一标识符
        let uniqueIdentifier = DPUser.getUniqueIdentifier()
        print("当前设备唯一标识-UUID: \(uniqueIdentifier)")
    }
}

