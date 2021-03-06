//
//  MoviesDataManager.swift
//  SIVVI Movies
//
//  Created by Zouhair on 4/30/18.
//  Copyright © 2018 Zouhair. All rights reserved.
//

import Foundation

import Foundation
import Moya
import ObjectMapper

class MoviesDataManager {
    var moviesProvider = MoyaProvider<MoviesProvider>()
}


extension MoviesDataManager {
    
    /// get movies fro network filtering by criteria
    ///
    /// - Parameters:
    ///   - page: movie page
    ///   - sort_by: filter
    ///   - completion: callback
    func getMovies(page:Int,sort_by:String,completion:@escaping (_ success:Bool,_ reponse:MovieSection?,_ error:NSError?)-> Void) {
        moviesProvider.request(.fetchMoviesList(page: page, sort_by: sort_by)) { (result) in
            switch result {
            case .success(let data):
                do {    
                    let orderResponseJson = try JSONSerialization.jsonObject(with: data.data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                    

                    if let resultsResponse = Mapper<MovieSection>().map(JSONObject: orderResponseJson) {
                        print("JSON : \(resultsResponse)")
                        completion(true, resultsResponse, nil)
                    }else{
                        print("Error parsing json")
                        completion(false, nil, NSError(domain: "this.app", code: 121, userInfo: ["error":"Error parsing json"]))
                    }
                }catch{
                    completion(false, nil, error as NSError)
                }
            case .failure(let error):
                completion(false, nil, error as NSError)
            }
        }
    }
}
