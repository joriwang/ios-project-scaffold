//
//  CYNet.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/8.
//

import Foundation
import Moya

let net = MoyaProvider<CYNet>(plugins: [MoyaLogPlugin()])

enum CYNet {
    case demo
    case demo2
}

extension CYNet: TargetType {
    var baseURL: URL {
        return URL(string: "https://my-json-server.typicode.com")!
    }

    var path: String {
        switch self {
        case .demo:
            return "/joriwang/api-test/moxiu"
        case .demo2:
            return "/joriwang/api-test/moxiu2"
        }
    }

    var method: Moya.Method {
        switch self {
        case .demo, .demo2:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .demo, .demo2:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .demo, .demo2:
            return nil
        }
    }
}
