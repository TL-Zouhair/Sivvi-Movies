//
//  MovieSection.swift
//  SIVVI Movies
//
//  Created by Zouhair on 4/30/18.
//  Copyright © 2018 Zouhair. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

class MovieSection: Mappable {

    var movies:[Movie] = [Movie]()
    var totalPages:Int = 0
    var totalResults:Int = 0
    var refresh = PublishSubject<()>()
    
    required init?(map: Map) {
    }
    required init(){}
    
    func mapping(map: Map) {
        movies <- map["results"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
    }
    
    func count() -> Int {
        return movies.count
    }
}
