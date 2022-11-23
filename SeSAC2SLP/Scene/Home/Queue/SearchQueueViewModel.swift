//
//  SearchQueueViewModel.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/18.
//

import UIKit

class SearchQueueViewModel {
    
    var userStudyList = CObservable(User.studylist)

    var recommend = CObservable(User.fromRecommend)
    
    var result: CObservable<SearchInfo>?
    
    var studyList: CObservable<Study>?
    
    func setCell() {

    }
    
    func setRecommend(result: SearchInfo, collectionView: UICollectionView) -> [Study] {
        let recommend = result.fromRecommend.map { Study(name: $0, type: .recommend) } ?? []
        var studyListFromDB = result.fromQueueDB.map{ $0.studylist }.flatMap { $0 }.map { Study(name: $0, type: .fromStudyListDB) } ?? []
        
        // 중복 제거
        recommend.forEach { recommendValue in
            studyListFromDB.forEach { studyListFromDBValue in
                if recommendValue.name == studyListFromDBValue.name {
                    studyListFromDB.removeAll(where: {$0.name == studyListFromDBValue.name})
                }
            }
        }
        
        var removedArray = [Study]()
        for i in studyListFromDB {
            if removedArray.contains(i) == false {
                removedArray.append(i)
            }
        }

        var results = recommend + removedArray
        results.removeAll(where: { $0.name == "anything" })
        results.removeAll(where: { $0.name == "" })
        print("HomeViewAPI:", recommend, studyListFromDB, results)
        collectionView.reloadData()
        
        return results
    }
}
