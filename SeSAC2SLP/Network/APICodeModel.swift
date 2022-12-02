//
//  APIErrorModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/14.
//

import Foundation

struct UserInfo: Codable {
    let photo: String
    let email: String
    let username: String
}

struct Queue: Codable {
    let lat: Double
    let long: Double
    let studylist: [String]
}

enum MatchedCode: Int {
    case match0 = 0
    case match1 = 1
    case match2 = 2
}

extension MatchedCode {
    var maatchedImageName: String? {
        switch self {
        case .match0:
            return "match0"
        case .match1:
            return "match1"
        case .match2:
            return "match2"
        }
    }
}

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

enum QueueStateCode: Int, Error {
    case match = 200
    case normal = 201
    case firebaseTokenError = 401
    case notMember = 406
    case serverError = 500
    case clientError = 501
}

enum QueueCode: Int, Error {
    case success = 200
    case block = 201
    case penaltyFirst = 203
    case penaltySecond = 204
    case penaltyThird = 205
    case firebaseTokenError = 401
    case notMember = 406
    case serverError = 500
    case clientError = 501
}

enum SesacCode: Int {
    case sesac_face_1 = 0
    case sesac_face_2
    case sesac_face_3
    case sesac_face_4
    case sesac_face_5
}

extension SesacCode {
    var sesacImageName: String? {
        switch self {
        case .sesac_face_1:
            return "sesac_face_1"
        case .sesac_face_2:
            return "sesac_face_2"
        case .sesac_face_3:
            return "sesac_face_3"
        case .sesac_face_4:
            return "sesac_face_4"
        case .sesac_face_5:
            return "sesac_face_5"
        }
    }
}

enum BackgroundCode: Int {
    case sesac_background_1 = 0
    case sesac_background_2
    case sesac_background_3
    case sesac_background_4
    case sesac_background_5
    case sesac_background_6
    case sesac_background_7
    case sesac_background_8
    case sesac_background_9
    
}

extension BackgroundCode {
    var backgroundImageName: String? {
        switch self {
        case .sesac_background_1:
            return "sesac_background_1"
        case .sesac_background_2:
            return "sesac_background_2"
        case .sesac_background_3:
            return "sesac_background_3"
        case .sesac_background_4:
            return "sesac_background_4"
        case .sesac_background_5:
            return "sesac_background_5"
        case .sesac_background_6:
            return "sesac_background_6"
        case .sesac_background_7:
            return "sesac_background_7"
        case .sesac_background_8:
            return "sesac_background_8"
        case .sesac_background_9:
            return "sesac_background_9"
        }
    }
}

