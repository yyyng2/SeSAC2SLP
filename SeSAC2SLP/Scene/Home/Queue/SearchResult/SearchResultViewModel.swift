//
//  SearchResultViewModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/27.
//

import Foundation

class SearchResultViewModel {
    var fromQueueDB: CObservable<[FromQueueDB]>?
    
    var fromQueueDBRequested: CObservable<[FromQueueDB]>?
}
