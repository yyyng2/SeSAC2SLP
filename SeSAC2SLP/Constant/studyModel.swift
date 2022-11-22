//
//  studyModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/22.
//

struct Study {
    let name: String
    let type: StudyModelType
}

enum StudyModelType {
    case recommend
    case fromStudyListDB
}

extension Study: Equatable {
    static func ==(lhs: Study, rhs: Study) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type
    }
}
