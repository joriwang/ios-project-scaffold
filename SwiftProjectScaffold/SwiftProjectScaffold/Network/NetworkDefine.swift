//
//  NetworkDefine.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/9.
//

import Foundation
import HandyJSON
import Moya

struct CYResponseModel<T>: HandyJSON {
    var code: Int = 0
    var message: String?
    var data: T?
}

extension CYResponseModel where T: HandyJSON {
    static func parse(data: Data) -> CYResponseModel? {
        return CYResponseModel.deserialize(from: String(data: data, encoding: .utf8), designatedPath: nil)
    }
}

extension CYResponseModel where T: Collection, T.Element: HandyJSON {
    static func parse(data: Data) -> CYResponseModel? {
        let obj = CYResponseModel.deserialize(from: String(data: data, encoding: .utf8), designatedPath: nil)
        if let object = obj, object.data == nil {
            return nil
        }
        return obj
    }
}

enum CYNetworkError: Swift.Error {
    case fail(message: String, code: Int)
}

public struct CYProgressResponse<T: HandyJSON> {

    /// The optional response of the request.
    public let response: Response?

    /// An object that conveys ongoing progress for a given request.
    public let progressObject: Progress?

    public let model: T?

    /// Initializes a `ProgressResponse`.
    public init(progress: Progress? = nil, response: Response? = nil, model: T? = nil) {
        self.progressObject = progress
        self.response = response
        self.model = model
    }

    /// The fraction of the overall work completed by the progress object.
    public var progress: Double {
        if completed {
            return 1.0
        } else if let progressObject = progressObject, progressObject.totalUnitCount > 0 {
            // if the Content-Length is specified we can rely on `fractionCompleted`
            return progressObject.fractionCompleted
        } else {
            // if the Content-Length is not specified, return progress 0.0 until it's completed
            return 0.0
        }
    }

    /// A Boolean value stating whether the request is completed.
    public var completed: Bool { response != nil }
}
