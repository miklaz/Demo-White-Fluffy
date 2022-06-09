//
//  NetworkDataFetcher.swift
//  Demo-White&Fluffy
//
//  Created by Михаил Зайцев on 07.06.2022.
//

import Foundation

final class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    func fetchImeages (searchTerm: String, completion: @escaping (SearchResults?) -> ()) {
        networkService.requestSearch(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {return nil}
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Faled Json Decodable!", jsonError)
            return nil
        }
    }
}
