//
//  MoyaProvider+X.swift
//  Example
//
//  Created by wangcong on 22/06/2017.
//  Copyright © 2017 ApterKing. All rights reserved.
//

import Moya

public extension MoyaProvider {

    // default  EndpointClosure
    public final class var defaultEndpointColsure: EndpointClosure {
        return { (target: Target) -> Endpoint<Target> in
            let defaultEndpoint = MoyaProvider<Target>.defaultEndpointMapping(for: target)
            if let httpHeaderFields = target.httpHeaderFields {
              return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
            }
            return defaultEndpoint
        }
    }

    // default RequestClosure
    public final class var defaultRequestClosure: RequestClosure {
        return MoyaProvider.defaultRequestMapping
    }

    // default StubClosure
    public final class var defaultStubClosure: StubClosure {
        return MoyaProvider.neverStub
    }

    // default Manager
    public final class var defaultManager: Manager {
        return MoyaProvider.defaultAlamofireManager()
    }

}
