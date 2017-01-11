//
//  SafePromise.swift
//  BleClientManager
//
//  Created by Przemysław Lenart on 25/10/16.
//  Copyright © 2016 Polidea. All rights reserved.
//

import Foundation

public typealias Resolve = (AnyObject?) -> ()
public typealias Reject = (NSString?, NSString?, NSError?) -> ()

class SafePromise {
    let resolveFunc: Resolve
    let rejectFunc: Reject
    var finished = false

    init(resolve: @escaping Resolve, reject: @escaping Reject) {
        self.resolveFunc = resolve
        self.rejectFunc = reject
    }

    func resolve(_ value: AnyObject? = nil) {
        if (!finished) {
            self.resolveFunc(value)
            finished = true
        }
    }

    func reject(code: String? = nil, message: String? = nil, error: NSError? = nil) {
        if (!finished) {
            rejectFunc(code as NSString?, message as NSString?, error)
            finished = true
        }
    }
}
