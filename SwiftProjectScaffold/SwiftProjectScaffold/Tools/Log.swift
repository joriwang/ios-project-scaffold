//
//  Log.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/10.
//

import Foundation
import CocoaLumberjack

final class log {
    static func d(_ message: String) {
        DDLogDebug(message, file: "hehe", line: 10086)
    }
    
    static func i(_ message: String) {
        DDLogInfo(message)
    }
    
    static func e(_ message: String) {
        DDLogError(message)
    }
}
