//
//  SearchQueueViewModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

import RxSwift
import RxCocoa

class SearchQueueViewModel {
    
    var userStudyList = CObservable(User.studylist)

    var recommend = CObservable(User.fromRecommend)
    
    var result: CObservable<SearchInfo>?
    
    var studyList: CObservable<[Study]>?
    
    func setRecommend(result: SearchInfo, collectionView: UICollectionView) -> [Study] {
        
        let recommend = result.fromRecommend.map { Study(name: $0.removeBackslash, type: .recommend) } ?? []
        var studyListFromDB = result.fromQueueDB.map{ $0.studylist }.flatMap { $0 }.map { Study(name: $0.removeBackslash, type: .fromStudyListDB) } ?? []
        var userStudy = User.studylist
        
        // 중복 제거
        recommend.forEach { recommendValue in
            studyListFromDB.forEach { studyListFromDBValue in
                if recommendValue.name == studyListFromDBValue.name {
                    studyListFromDB.removeAll(where: {$0.name == studyListFromDBValue.name})
                }
            }
        }
        
        var dataDeduplication = [Study]()
        for i in studyListFromDB {
            if dataDeduplication.contains(i) == false {
                dataDeduplication.append(i)
            }
        }
        
        for i in userStudy {
            dataDeduplication.removeAll(where: { $0.name == "\(i)" })
        }

        var results = recommend + dataDeduplication
        results.removeAll(where: { $0.name == "anything" })
        results.removeAll(where: { $0.name == "" })
        print("HomeViewAPI:", recommend, studyListFromDB, results)
        
        studyList?.value = results
        collectionView.reloadData()
        
        return results
    }
}
