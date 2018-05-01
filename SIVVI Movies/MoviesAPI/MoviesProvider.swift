//
//  MoviesProvider.swift
//  SIVVI Movies
//
//  Created by Zouhair on 4/30/18.
//  Copyright © 2018 Zouhair. All rights reserved.
//

import Foundation
import Moya

enum MoviesProvider {
    case fetchMoviesList(page:Int,sort_by:String)
}

extension MoviesProvider : TargetType {
    
    var baseURL: URL { return SettingsConstants.baseURL }
    
    var path: String {
        switch self {
            
        case .fetchMoviesList:
            return "/discover/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .fetchMoviesList:
            return .get
            
        }
    }
    
    var task: Task {
        switch self {
        case .fetchMoviesList:
            return .requestParameters(parameters: self.parameters!, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        case .fetchMoviesList(let page,let sort_by):
            return ["page":page as AnyObject,"sort_by":sort_by as AnyObject,"api_key":SettingsConstants.apiKey as AnyObject]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}

