//
//  SearchQueueViewModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import Foundation

class SearchQueueViewModel {
    
    var userStudyList = CObservable(User.studylist)

    var recommend = CObservable(User.fromRecommend)
    
    func setCell() {
//        APIService().
    }
}
