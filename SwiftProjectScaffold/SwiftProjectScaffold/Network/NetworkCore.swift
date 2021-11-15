//
//  Network.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/6.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

public extension Reactive where Base: MoyaProviderType {

    func cy_request<T: HandyJSON>(_ token: Base.Target, zclass: T.Type, callbackQueue: DispatchQueue? = nil) -> Single<T> {
        Single.create { [weak base] single in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    guard let model = CYResponseModel<T>.parse(data: response.data) else {
                        single(.failure(CYNetworkError.fail(message: "解析失败", code: 500)))
                        return
                    }
                    guard model.code == 200, let result = model.data else {
                        single(.failure(CYNetworkError.fail(message: model.message ?? "解析 Json 失败", code: 501)))
                        return
                    }
                    single(.success(result))
                case let .failure(error):
                    single(.failure(CYNetworkError.fail(message: "\(error)", code: error.errorCode)))
                }
            }

            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
    
    func cy_request<T: HandyJSON>(_ token: Base.Target, element: T.Type, callbackQueue: DispatchQueue? = nil) -> Single<[T]> {
        Single.create { [weak base] single in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    guard let model = CYResponseModel<[T]>.parse(data: response.data) else {
                        single(.failure(CYNetworkError.fail(message: "解析失败", code: 500)))
                        return
                    }
                    guard model.code == 200, let result = model.data else {
                        single(.failure(CYNetworkError.fail(message: model.message ?? "解析 Json 失败", code: 501)))
                        return
                    }
                    single(.success(result))
                case let .failure(error):
                    single(.failure(CYNetworkError.fail(message: "\(error)", code: error.errorCode)))
                }
            }

            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }

    /// Designated request-making method with progress.
    func cy_requestWithProgress<T: HandyJSON>(_ token: Base.Target, callbackQueue: DispatchQueue? = nil, zclass: T.Type) -> Observable<CYProgressResponse<T>> {

        let response: Observable<CYProgressResponse<T>> = Observable.create { [weak base] observer in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: { progress in
                if progress.completed {
                    guard let response = progress.response, let baseModel = CYResponseModel<T>.parse(data: response.data) else {
                        observer.onError(CYNetworkError.fail(message: "解析失败", code: 500))
                        return
                    }
                    if baseModel.code != 200 {
                        observer.onError(CYNetworkError.fail(message: baseModel.message ?? "请求参数错误", code: baseModel.code))
                        return
                    }
                    guard let model = baseModel.data else {
                        observer.onError(CYNetworkError.fail(message: "数据结构错误", code: 500))
                        return
                    }
                    observer.onNext(CYProgressResponse(progress: progress.progressObject, response: progress.response, model: model))
                } else {
                    observer.onNext(CYProgressResponse(progress: progress.progressObject, response: progress.response, model: nil))
                }
            }, completion: { result in
                switch result {
                case .success:
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(CYNetworkError.fail(message: "\(error)", code: error.errorCode))
                }
            })

            return Disposables.create {
                cancellableToken?.cancel()
            }
        }

        // Accumulate all progress and combine them when the result comes
        return response.scan(CYProgressResponse()) { last, progress in
            let progressObject = progress.progressObject ?? last.progressObject
            let response = progress.response ?? last.response
            return CYProgressResponse(progress: progressObject, response: response, model: last.model)
        }
    }
}
