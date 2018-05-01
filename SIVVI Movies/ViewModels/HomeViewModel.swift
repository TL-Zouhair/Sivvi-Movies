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

enum Sections : String {
    case Popular = "popularity.desc"
    case Latest = "latest.desc"
    case Revenue = "revenue.desc"
    case VoteAverage = "vote_average.desc"
    case VoteCount = "vote_count.desc"
}

class HomeViewModel : NSObject {
    
    var dataManager:MoviesDataManager
    
    var loadMore = PublishSubject<Int>()
    var showProgress = PublishSubject<Bool>()
    var showError = PublishSubject<String>()
    var refreshTable = PublishSubject<()>()
    
    
    var popularSection = MovieSection()
    var popularCurrentPage = 0
    
    var revenueSection = MovieSection()
    var revenueCurrentPage = 0
    
    var topRatedSection = MovieSection()
    var topRatedCurrentPage = 0
    
    var latestSection = MovieSection()
    var latestCurrentPage = 0
    
    var bestRatedSection = MovieSection()
    var bestRatedCurrentPage = 0
    
    
    init(dataManager:MoviesDataManager) {
        self.dataManager = dataManager
    }
    
    func loadMorePopular() {
        popularCurrentPage += 1
        getSections(page: popularCurrentPage, sort_by: Sections.Popular, section: popularSection)
    }
    
    func loadMoreTopRated() {
        topRatedCurrentPage += 1
        getSections(page: topRatedCurrentPage, sort_by: Sections.VoteCount, section: topRatedSection)
    }
    
    func loadMoreRevenue() {
        revenueCurrentPage += 1
        getSections(page: revenueCurrentPage, sort_by: Sections.Revenue, section: revenueSection)
    }
    
    func loadMoreLastest() {
        latestCurrentPage += 1
        getSections(page: latestCurrentPage, sort_by: Sections.Latest, section: latestSection)
    }
    
    func loadMoreBestRated() {
        bestRatedCurrentPage += 1
        getSections(page: bestRatedCurrentPage, sort_by: Sections.VoteAverage, section: bestRatedSection)
    }
    
    
    /// Get Section by page number and filter
    ///
    /// - Parameters:
    ///   - page: page number - pagination
    ///   - sort_by: filter See enum Sections
    ///   - section: section storage
    func getSections(page: Int, sort_by: Sections,section:MovieSection) {
        //call the API Manager
        dataManager.getMovies(page: page, sort_by: sort_by.rawValue) { (success, _moviesSection, error) in
            if success {
                if let mvs = _moviesSection?.movies {
                    section.movies.append(contentsOf: mvs)
                    section.refresh.onNext(())
                }else {
                    //showError.onNext("")
                }
            } else {
                //showError.onNext("")
            }
        }
    }
}
