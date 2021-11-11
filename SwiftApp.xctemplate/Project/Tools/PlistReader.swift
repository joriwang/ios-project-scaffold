//
//  PlistReader.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/10.
//

import Foundation

private var cache: NSCache<NSString, AnyObject> = {
    let r = NSCache<NSString, AnyObject>()
    r.name = "Local Plist Reader Cache"
    return r
}()

final class PlistReader {
    
    static func read(_ url: URL, cacheEnabled: Bool = true) -> NSDictionary? {
        let r = NSDictionary(contentsOf: url)
        if cacheEnabled, let rr = r {
            cache.setObject(rr, forKey: url.absoluteString as NSString)
        }
        return r
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
