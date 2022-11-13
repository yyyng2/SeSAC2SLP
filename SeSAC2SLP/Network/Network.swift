//
//  Network.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/13.
//

import Foundation

import Alamofire

final class Network {
    static let shared = Network()
    
    private init() {}
    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod = .get, parameter: [String:String]? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameter, headers: headers).responseDecodable(of: T.self) { response in
            switch response.result {
                
            case .success(let data):
                completion(.success(data)) // 탈출클로저, result, enum, 연관값
            case .failure(_):
                
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = SeSACError(rawValue: statusCode) else { return }
                
                completion(.failure(error))
            }
        }
    }
    
}
