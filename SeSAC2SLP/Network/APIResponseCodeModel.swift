//
//  APIRequestCodeModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/12/02.
//

import Foundation

struct Login: Codable {
    let uid: String
    let phoneNumber: String
    let email: String
    let FCMtoken: String
    let nick: String
    let birth: String
    let gender: Int
    let study: String
    let comment: [String]
    let reputation: [Int]
    let sesac: Int
    let sesacCollection: [Int]
    let background: Int
    let backgroundCollection: [Int]
    let purchaseToken: [String]
    let transactionId: [String]
    let reviewedBefore: [String]
    let reportedNum: Int
    let reportedUser: [String]
    let dodgepenalty: Int
    let dodgeNum: Int
    let ageMin: Int
    let ageMax: Int
    let searchable: Int
    let createdAt: String
}

struct WithDraw: Codable {
    let token: String
}

struct QueueState: Codable {
    let dodged: Int
    let matched: Int
    let reviewed: Int
    let matchedNick: String
    let matchedUid: String
}

struct SearchInfo: Codable {
    let fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    let fromRecommend: [String]
}

struct FromQueueDB: Codable {
    let uid: String
    let nick: String
    let lat: Double
    let long: Double
    let reputation: [Int]
    let studylist: [String]
    let reviews: [String]
    let gender: Int
    let type: Int
    let sesac: Int
    let background: Int
}
