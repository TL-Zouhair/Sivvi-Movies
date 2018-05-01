//
//  MovieSection.swift
//  SIVVI Movies
//
//  Created by Zouhair on 4/30/18.
//  Copyright © 2018 Zouhair. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieSection: Mappable {
    
    var movies:[Movie]?
    var totalPages:Int?
    var totalResults:Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        movies <- map["results"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
    }
    
    func count() -> Int {
        guard let movies = movies else {
            return 0
        }
        
        return movies.count
    }
}
