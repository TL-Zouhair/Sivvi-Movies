//
//  HomeViewController.swift
//  SIVVI Movies
//
//  Created by Zouhair on 4/30/18.
//  Copyright © 2018 Zouhair. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class HomeViewController : UIViewController {
    
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var revenueCollectionView: UICollectionView!
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var latestCollectionView: UICollectionView!
    @IBOutlet weak var bestRatedCollectionView: UICollectionView!
    
    
    var homeViewModel:HomeViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        self.title = "SiVVI Movies"
        
        popularCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCellHome")
        topRatedCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCellHome")
        revenueCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCellHome")
        latestCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCellHome")
        bestRatedCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCellHome")
        
        homeViewModel = HomeViewModel(dataManager: MoviesDataManager())
        
        //Popular
        homeViewModel.popularSection.refresh.subscribe { [weak self](_) in
            self?.popularCollectionView.reloadData()
        }.disposed(by: disposeBag)
        homeViewModel.loadMorePopular()
        
        popularCollectionView.rx.didEndDisplayingCell.asObservable().bind { [unowned self](cell,indexPath) in
            if self.homeViewModel.popularSection.count() - indexPath.row < 8 {
                self.homeViewModel.loadMorePopular()
            }
        }.disposed(by: disposeBag)
        
        popularCollectionView.rx.itemSelected.asObservable().bind { [weak self](indexPath) in
            if let movie = self?.homeViewModel.popularSection.movies[indexPath.row] {
                let detail = self?.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
                detail.viewModel = DetailViewModel(movie: movie)
                self?.navigationController?.pushViewController(detail, animated: true)
            }
        }.disposed(by: disposeBag)
        
        popularCollectionView.dataSource = self
        
        //topRated
        homeViewModel.topRatedSection.refresh.subscribe { [weak self](_) in
            self?.topRatedCollectionView.reloadData()
            }.disposed(by: disposeBag)
        homeViewModel.loadMoreTopRated()
        
        topRatedCollectionView.rx.didEndDisplayingCell.asObservable().bind { [unowned self](cell,indexPath) in
            if self.homeViewModel.topRatedSection.count() - indexPath.row < 8 {
                self.homeViewModel.loadMoreTopRated()
            }
            }.disposed(by: disposeBag)
        
        topRatedCollectionView.rx.itemSelected.asObservable().bind { [weak self](indexPath) in
            if let movie = self?.homeViewModel.topRatedSection.movies[indexPath.row] {
                let detail = self?.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
                detail.viewModel = DetailViewModel(movie: movie)
                self?.navigationController?.pushViewController(detail, animated: true)
            }
            }.disposed(by: disposeBag)
        topRatedCollectionView.dataSource = self
        
        //Revenue
        homeViewModel.revenueSection.refresh.subscribe { [weak self](_) in
            self?.revenueCollectionView.reloadData()
            }.disposed(by: disposeBag)
        homeViewModel.loadMoreRevenue()
        
        revenueCollectionView.rx.didEndDisplayingCell.asObservable().bind { [unowned self](cell,indexPath) in
            if self.homeViewModel.revenueSection.count() - indexPath.row < 8 {
                self.homeViewModel.loadMoreRevenue()
            }
            }.disposed(by: disposeBag)
        
        revenueCollectionView.rx.itemSelected.asObservable().bind { [weak self](indexPath) in
            if let movie = self?.homeViewModel.revenueSection.movies[indexPath.row] {
                let detail = self?.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
                detail.viewModel = DetailViewModel(movie: movie)
                self?.navigationController?.pushViewController(detail, animated: true)
            }
            }.disposed(by: disposeBag)
        revenueCollectionView.dataSource = self
        
        //Latest
        homeViewModel.latestSection.refresh.subscribe { [weak self](_) in
            self?.latestCollectionView.reloadData()
            }.disposed(by: disposeBag)
        homeViewModel.loadMoreLastest()
        
        latestCollectionView.rx.didEndDisplayingCell.asObservable().bind { [unowned self](cell,indexPath) in
            if self.homeViewModel.latestSection.count() - indexPath.row < 8 {
                self.homeViewModel.loadMoreLastest()
            }
            }.disposed(by: disposeBag)
        
        latestCollectionView.rx.itemSelected.asObservable().bind { [weak self](indexPath) in
            if let movie = self?.homeViewModel.latestSection.movies[indexPath.row] {
                let detail = self?.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
                detail.viewModel = DetailViewModel(movie: movie)
                self?.navigationController?.pushViewController(detail, animated: true)
            }
            }.disposed(by: disposeBag)
        latestCollectionView.dataSource = self
        
        //BestRated
        homeViewModel.bestRatedSection.refresh.subscribe { [weak self](_) in
            self?.bestRatedCollectionView.reloadData()
            }.disposed(by: disposeBag)
        homeViewModel.loadMoreBestRated()
        
        bestRatedCollectionView.rx.didEndDisplayingCell.asObservable().bind { [unowned self](cell,indexPath) in
            if self.homeViewModel.bestRatedSection.count() - indexPath.row < 8 {
                self.homeViewModel.loadMoreBestRated()
            }
            }.disposed(by: disposeBag)
        
        bestRatedCollectionView.rx.itemSelected.asObservable().bind { [weak self] (indexPath) in
            if let movie = self?.homeViewModel.bestRatedSection.movies[indexPath.row] {
                let detail = self?.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
                detail.viewModel = DetailViewModel(movie: movie)
                self?.navigationController?.pushViewController(detail, animated: true)
            }
            }.disposed(by: disposeBag)
        
        bestRatedCollectionView.dataSource = self
    }
}

extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return homeViewModel.topRatedSection.count()
        }else if collectionView.tag == 2 {
            return homeViewModel.revenueSection.count()
        }else if collectionView.tag == 3 {
            return homeViewModel.latestSection.count()
        }else if collectionView.tag == 4 {
            return homeViewModel.bestRatedSection.count()
        }else {
            return homeViewModel.popularSection.count()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCellHome", for: indexPath) as! MovieCollectionViewCell
        if collectionView.tag == 1 {
            let movie = homeViewModel.topRatedSection.movies[indexPath.row]
            cell.setUp(movie: movie)
        }else if collectionView.tag == 2 {
            let movie = homeViewModel.revenueSection.movies[indexPath.row]
            cell.setUp(movie: movie)
        }else if collectionView.tag == 3 {
            let movie = homeViewModel.latestSection.movies[indexPath.row]
            cell.setUp(movie: movie)
        }else if collectionView.tag == 4 {
            let movie = homeViewModel.bestRatedSection.movies[indexPath.row]
            cell.setUp(movie: movie)
        }else {
            let movie = homeViewModel.popularSection.movies[indexPath.row]
            cell.setUp(movie: movie)
        }
        return cell
    }
}

