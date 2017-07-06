//
//  MoyaActivityPlugin.swift
//  Example
//
//  Created by wangcong on 23/06/2017.
//  Copyright © 2017 ApterKing. All rights reserved.
//

import Moya
import Result

// 监听所有网络事件
public class MoyaActivityPlugin: PluginType {

    // 准备
    public typealias PrepareClosure = (_ request: URLRequest, _ target: TargetType) -> URLRequest
    // 将要发生请求
    public typealias WillSendClosure = (_ request: RequestType, _ target: TargetType) -> Void
    // 收到数据
    public typealias DidReceiveClosure = (_ result: Result<Moya.Response, MoyaError>, _ target: TargetType) -> Void
    // 请求进度
    public typealias ProcessClosure = (_ result: Result<Response, MoyaError>, _ target: TargetType) -> Result<Response, MoyaError>

    public var prepareClosure: PrepareClosure?
    public var willSendClosure: WillSendClosure?
    public var didReceiveClosure: DidReceiveClosure?
    public var processClosure: ProcessClosure?
    
    public init() {
        
    }

    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let prepare = prepareClosure {
            return prepare(request, target)
        }
        return request
    }

    public func willSend(_ request: RequestType, target: TargetType) {
        if let willSend = willSendClosure {
            willSend(request, target)
        }
    }

    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        if let didReceive = didReceiveClosure {
            didReceive(result, target)
        }
    }

    public func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        if let process = processClosure {
            return process(result, target)
        }
        return result
    }

}
