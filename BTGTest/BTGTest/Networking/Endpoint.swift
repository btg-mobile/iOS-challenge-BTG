//
//  Endpoint.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Completion Blocks
typealias RequestSuccess = (Any?) -> ()
typealias RequestFailure = (EndpointError?) -> ()

class Endpoint {

    // MARK: - Paramethers
    let urlPath: URLPath
    let method: HTTPMethod
    let parameters: [String: Any]?

    // MARK: - Life Cycle
    init(path: URLPath, method: HTTPMethod, parameters: [String: Any]?) {
        self.urlPath = path
        self.method = method
        self.parameters = parameters
    }

    // MARK: - Request Handling
    func makeRequest(success: @escaping RequestSuccess, failure: @escaping RequestFailure) {
        printRequest()

        let request = Alamofire.request(urlPath.fullPath,
                                        method: method,
                                        parameters: parameters,
                                        encoding: URLEncoding.default,
                                        headers: nil)

        request.validate(statusCode: 200..<300).responseJSON { response in
            self.printResponse(response)

            guard let responseInfo = response.response else {
                failure(EndpointError.unkown())
                return
            }

            if 200..<300 ~= responseInfo.statusCode {
                success(response.result.value)
            } else {
                if let errorData = response.data  {
                    do {
                        if let error = try JSONSerialization.jsonObject(with: errorData) as? [String: AnyObject] {
                            failure(EndpointError(data: error, statusCode: responseInfo.statusCode))
                            return
                        }
                    } catch {
                        print("Unable to parse endpoint error")
                    }
                }

                failure(EndpointError.unkown(statusCode: responseInfo.statusCode))
            }
        }
    }

    // MARK: - Information Log
    private func printRequest() {
        print("\n>>> Request \(urlPath.fullPath) - \(Date())")
        var details = "- Path: \(urlPath.path)\n- Method: \(method)"

        if let parameters = parameters {
            details += "\n- Parameters:\n\(parameters)"
        }

        print(details)
    }

    private func printResponse(_ response: DataResponse<Any>) {
        if let responseRequest = response.request, let requestURL = responseRequest.url {
            print("\n>>> Response \(String(describing: requestURL.absoluteString)) - \(Date())")
        }

        let statusCode = response.response == nil ? 9999 : response.response!.statusCode
        var responseText: String? = nil
        if let responseData = response.data {
            responseText = String(data: responseData, encoding: .utf8)
        }

        print("API Response(\(statusCode)): \(responseText ?? "Response Data Unavailable")")
    }

}

