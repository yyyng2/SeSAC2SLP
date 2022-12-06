//
//  ChatRealmModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/12/06.
//

import Foundation

import RealmSwift

final class ChatList: Object{
    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var createdAt: String
    
    convenience init(title: String, content: String?, createdAt: String) {
        self.init()
        self.title = title
        self.content = content
        self.createdAt = createdAt
    }
}
