//
//  MoyaPlugins.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/11.
//

import Foundation
import Moya

// swiftlint:disable all
struct MoyaLogPlugin: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        guard let url = request.request?.url else {
            log.e("[Network][Req] invalid request [BaseURL]\(target.baseURL)[Target]\(target.self)")
            return
        }
        log.d("[Network][Req][URL]\(url)[Method]\(request.request!.method?.rawValue ?? "empty method")[Headers]\(request.request!.headers.dictionary.description)")
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .failure(let e):
            if let resp = e.response {
                log.e("[Network][Resp][Failed][Code]\(e.errorCode)[URL]\(resp.response?.url?.absoluteString ?? "empty url")[Method]\(resp.request?.method?.rawValue ?? "empty method")[Headers]\(resp.response?.headers.dictionary.description ?? "empty headers")[Desc]\(e.errorDescription ?? "empty desc")")
            } else {
                log.e("[Network][Resp][Failed][Code]\(e.errorCode)[Desc]\(e.errorDescription ?? "empty desc")[Info] no response")
            }
            
        case .success(let resp):
            log.d("[Network][Resp][Done][URL]\(resp.response?.url?.absoluteString ?? "empty url")[Method]\(resp.request!.method!.rawValue)[BaseURL]\(target.baseURL)[Data]\(String(data: resp.data, encoding: .utf8) ?? "parse data failed")")
            
        }
    }
}
// swiftlint:enable all
