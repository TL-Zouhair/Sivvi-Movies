//
//  DetailViewModel.swift
//  SIVVI Movies
//
//  Created by Zouhair on 5/1/18.
//  Copyright © 2018 Zouhair. All rights reserved.
//

import Foundation
import RxSwift

class DetailViewModel {
    var movie:Movie
    let drop = Variable<String?>("")
    let title = Variable<String?>("")
    let overview = Variable<String?>("")
    let rating = Variable<Float?>(0_0)

    
    init(movie:Movie) {
        self.movie = movie
        drop.value = movie.backDropPath ?? ""
        title.value = movie.title ?? ""
        overview.value = movie.overview ?? ""
        rating.value = movie.voteAverage ?? 0_0
    }
    
    
}
