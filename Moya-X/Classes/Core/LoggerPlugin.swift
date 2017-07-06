//
//  LoggerPlugin.swift
//  Example
//
//  Created by wangcong on 23/06/2017.
//  Copyright © 2017 ApterKing. All rights reserved.
//

import Moya
import Result

public final class LoggerPlugin: PluginType {

    fileprivate var isVerbose: Bool
    fileprivate var tag: String

    public init(verbose: Bool = false, tag: String = "Moya-X_Logger") {
        self.isVerbose = verbose
        self.tag = tag
    }

    public func willSend(_ request: RequestType, target: TargetType) {
        logItems(items: output(request: request, target: target))
    }

    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        logItems(items: output(result: result, target: target))
    }

    fileprivate func logItems(items: [String]) {
        if isVerbose {
            items.forEach { print("\n\($0)") }
        }
    }

}

private extension LoggerPlugin {

    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        formatter.locale = Locale.current
        return formatter.string(from: Date())
    }

    final func format(identifier: String, message: String) -> String {
        return "\(tag) \(date) \(identifier): \(message)"
    }

    final func output(request: RequestType, target: TargetType) -> [String] {

        var output: [String] = []

        output += [format(identifier: "Request", message: request.request?.description ?? "Invalid Request")]

        if let httpMethod = request.request?.httpMethod {
            output += [format(identifier: "Request Method", message: httpMethod)]
        }

        if let headers = request.request?.allHTTPHeaderFields {
            output += [format(identifier: "Request Headers", message: headers.description)]
        }

        if let body = request.request?.httpBody, let stringOutput = String(data: body, encoding: .utf8) {
            output += [format(identifier: "Request Body", message: stringOutput)]
        }

        if let bodyStream = request.request?.httpBodyStream {
            output += [format(identifier: "Request Body Stream", message: bodyStream.description)]
        }

        return output
    }

    final func output(result: Result<Response, MoyaError>, target: TargetType) -> [String] {
        switch result {
        case .success(let response):
            if let urlResponse = response.response {
                var output: [String] = []
                if let httpURLResponse = urlResponse as? HTTPURLResponse {
                    output += [format(identifier: "Response header", message: httpURLResponse.allHeaderFields.description)]
                }
                if let resultString = try? response.mapString() {
                    output += [format(identifier: "Response String", message: resultString)]
                }
                return output
            } else {
                return [format(identifier: "Response", message: "Received empty network response for \(target).")]
            }
        case .failure(let error):
            return [format(identifier: "Response error", message: "\(error)")]
        }
    }

}
