//
//  APIErrorModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/14.
//

import Foundation

enum LoginCode: Int, Error {
    case success = 200
    case firebaseTokenError = 401
    case notMember = 406
    case serverError = 500
    case clientError = 501
}

enum SignCode: Int, Error {
    case success = 200
    case already = 201
    case badNickname = 202
    case firebaseTokenError = 401
    case notMember = 406
    case serverError = 500
    case clientError = 501
}
