//
//  EndpointError.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

// MARK: - EndpointError
class EndpointError {

    // MARK: - Constants
    static let UnkownErrorCode = 9999
    static let UnkownMessageText = "UNKOWN_ERROR_MESSAGE".localized

    // MARK: - Paramethers
    var statusCode: Int
    var message: String

    // MARK: - Life Cycle
    init() {
        statusCode = 0
        message = ""
    }

    convenience init(data: [String: Any], statusCode: Int) {
        self.init()
        self.statusCode = statusCode

        if let message = data["status_message"] as? String {
            self.message = message
        } else {
            self.message = EndpointError.UnkownMessageText
        }
    }

    // MARK: - Error Factory
    class func unkown(statusCode: Int = EndpointError.UnkownErrorCode) -> EndpointError {
        let error = EndpointError()
        error.statusCode = statusCode
        error.message = EndpointError.UnkownMessageText
        return error
    }

}
