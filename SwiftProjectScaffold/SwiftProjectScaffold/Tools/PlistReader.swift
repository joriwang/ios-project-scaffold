//
//  PlistReader.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/10.
//

import Foundation

private var cache: NSCache<NSString, AnyObject> = {
    let cache = NSCache<NSString, AnyObject>()
    cache.name = "Local Plist Reader Cache"
    return cache
}()

final class PlistReader {

    static func read(_ url: URL, cacheEnabled: Bool = true) -> NSDictionary? {
        let dicOpt = NSDictionary(contentsOf: url)
        if cacheEnabled, let dic = dicOpt {
            cache.setObject(dic, forKey: url.absoluteString as NSString)
        }
        return dicOpt
    }
    
    fileprivate static func getSDKConfig() -> NSDictionary {
        return read(R.file.sdkConfigPlist.url()!)!
    }
}

// MARK: - SDK Config
extension PlistReader {
    static func getUMengAppKey() -> String? {
        self.getSDKConfig().object(forKey: "UMengAppKey") as? String
    }
}
