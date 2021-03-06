//
//  Security.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/11.
//

import Foundation
import CryptoSwift

final class Security {
    static func aesDecrypt(_ cipherText: String, key: [UInt8], chip: BlockMode, padding: Padding = .pkcs7) -> String? {
        do {
            let cipherData = cipherText.data(using: .utf8)!
            let aes = try AES(key: key, blockMode: chip, padding: padding)
            let plainBytes = try aes.decrypt(cipherData.bytes)
            let plainData = Data(plainBytes)
            return String(data: plainData, encoding: .utf8)
        } catch {
            log.e("[Security][AES][Decrypt][Failed][Chip]\(chip.self)[Padding]\(padding)[Error]\(error.localizedDescription)[CipherText]\(cipherText)")
            return nil
        }

    }
}

// MARK: - CY
extension Security {
    static func cy_AESEncry(_ plainText: String) -> String? {
        let debugBeginDate = Date()
        let plainData = plainText.data(using: .utf8)!
        assert(plainData.count <= 12288, "aes 明文长度太长: \(plainData.count)")
        let randomString = "\(floor(Date().timeIntervalSince1970 * 1000))"
        let shaData = randomString.sha256().data(using: .utf8)!.bytes
        let key = Array(shaData.prefix(16))
        let ivBytes = Array(shaData.suffix(16))

        guard let aes = try? AES(key: key, blockMode: CBC(iv: ivBytes), padding: .pkcs7) else { return nil }

        guard let cipherBytes = try? aes.encrypt(plainData.bytes) else { return nil }

        let resultBytes = key + cipherBytes + ivBytes
        let base64 = Data(resultBytes).base64EncodedString()

        let debugEndDate = Date()
        log.d("[Security][AES] 耗时: \(debugEndDate.timeIntervalSince(debugBeginDate))秒")
        return base64
    }
}
