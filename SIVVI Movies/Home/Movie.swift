//
//  Movie.swift
//  SIVVI Movies
//
//  Created by Zouhair on 4/30/18.
//  Copyright © 2018 Zouhair. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: Mappable {
    
    var title:String?
    var rating:Float?
    var posterPath:String?
    var adult:Bool?
    var overview:String?
    var releaseDate:Date?
    var genreIds:[Int]?
    var id:Int?
    var originalTitle:String?
    var originalLanguage:String?
    var backDropPath:String?
    var popularity:Float?
    var voteCount:Int?
    var video:Bool?
    var voteAverage:Float?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        title <- map["title"]
        rating <- map["rating"]
        posterPath <- map["poster_path"]
        adult <- map["adult"]
        overview <- map["overview"]
        releaseDate <- (map["release_date"],CustomDateFormatTransform.init(formatString: "yyyy-MM-dd"))
        genreIds <- map["genre_ids"]
        id <- map["id"]
        originalTitle <- map["original_title"]
        originalLanguage <- map["original_language"]
        backDropPath <- map["backdrop_path"]
        popularity <- map["popularity"]
        voteCount <- map["vote_count"]
        video <- map["video"]
        voteAverage <- map["vote_average"]
    }
    
}
