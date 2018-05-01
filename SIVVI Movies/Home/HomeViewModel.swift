//
//  HomeViewModel.swift
//  SIVVI Movies
//
//  Created by Zouhair on 4/30/18.
//  Copyright © 2018 Zouhair. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class HomeViewModel : NSObject {
    var moviesSection:MovieSection?
    
    func
        getSections(page: Int, sort_by: String) {
        //call the API Manager
        
        MoviesDataManager.instance.getMovies(page: page, sort_by: sort_by) { (success, moviesSection, error) in
            if success {
                print(moviesSection!)
                if let ms = moviesSection,let newMovies = ms.movies {
                    self.moviesSection?.movies?.append(contentsOf: newMovies)
                }
            } else {
                
            }
        }

    }
}
