//
//  Endpoint.swift
//  MovieApp
//
//  Created by Jose Caraballo on 11/10/22.
//

import Foundation

protocol APIBuilder {
    //var urlRequest: URLRequest { get }
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
}

enum MovieAPI {
    case getMovie(id: Int)
    case getMovieList(endpoint: MovieListEndpoint)
    case getMovieImage(movieID: Int)
}

enum MovieListEndpoint: String {
    case airingToday = "airing_today"
    case upcoming = "on_the_air"
    case topRated = "top_rated"
    case popular
}

let apiKey = "88c5234252abcd1cc03e15c5b680195d"

extension MovieAPI: APIBuilder {
    
    var method: HTTPMethod {
        switch self {
        case .getMovie:
            return .get
        case .getMovieList:
            return .get
        case .getMovieImage:
            return .get
        }
    }
    
    var contentType: String {
        switch self {
            
        case .getMovie, .getMovieList, .getMovieImage:
            return "application/json;charset=utf-8"
        }
    }
    
    var body: [String : Any]? {
        switch self {
            
        case .getMovie:
            return nil
        case .getMovieList:
            return nil
        case .getMovieImage:
            return nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMovie:
            return nil
        case .getMovieList:
            return nil
        case .getMovieImage:
            return nil
        }
    }
    
    var baseUrl: String {
        switch self {
        case .getMovie(let id):
            return "https://api.themoviedb.org/3/tv/\(id)?api_key=\(apiKey)"
        case .getMovieList(let endpoint):
            return "https://api.themoviedb.org/3/tv/\(endpoint.rawValue)?api_key=\(apiKey)"
        case .getMovieImage(let id):
            return "https://api.themoviedb.org/3/tv/\(id)/images?api_key=\(apiKey)"
        }
    }
    
    var path: String {
        switch self {
        case .getMovie:
            return ""
        case .getMovieList:
            return ""
        case .getMovieImage:
            return ""
        }
    }
    
}

extension MovieAPI {
    
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }
    
    func asURLRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseUrl) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        print(request.url!)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers
        return request
    }
}
