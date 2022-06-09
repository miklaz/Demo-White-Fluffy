//
//  NetworkService.swift
//  Demo-White&Fluffy
//
//  Created by Михаил Зайцев on 07.06.2022.
//

import Foundation

final class NetworkService {
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID BfEvhCRcewcJBbdcCsZcqKfKuwCedc-tyacHqNi5J0E"
        
        return headers
    }
    
    func requestSearch(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = prepareParametersForSearch(searchTerm: searchTerm)
        let url = urlSearch(params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareParametersForSearch (searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        
        return parameters
    }
    
    private func urlSearch(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
    
//    func requestPhoto(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
//        let parameters = prepareParametersForPhoto(searchTerm: searchTerm)
//        let url = urlSearch(params: parameters)
//        var request = URLRequest(url: url)
//        request.allHTTPHeaderFields = prepareHeader()
//        request.httpMethod = "get"
//        let task = createDataTask(from: request, completion: completion)
//        task.resume()
//    }
//
//    private func prepareParametersForPhoto(searchTerm: String?) -> [String: String] {
//        var parameters = [String: String]()
//        parameters["query"] = searchTerm
//        parameters["page"] = String(1)
//        parameters["per_page"] = String(30)
//
//        return parameters
//    }
//
//    private func urlPhoto(params: [String: String]) -> URL {
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "api.unsplash.com"
//        components.path = "/search/photos"
//        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
//
//        return components.url!
//    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
}
