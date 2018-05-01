//
//  DetailViewController.swift
//  SIVVI Movies
//
//  Created by Zouhair on 4/30/18.
//  Copyright © 2018 Zouhair. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    @IBOutlet weak var bakcDrop: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var overView: UITextView!
    @IBOutlet weak var ratingBar: UIProgressView!
    @IBOutlet weak var rate: UILabel!
    
    var disposeBag = DisposeBag()
    
    var viewModel:DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.title.asObservable().bind(onNext: { (value) in
            self.title = value
        }).disposed(by: disposeBag)
    
        viewModel?.title.asObservable().bind(to: titleView.rx.text).disposed(by: disposeBag)
        viewModel?.drop.asObservable().bind(onNext: { [weak self](urlString) in
            if let urlString = urlString {
                var url = SettingsConstants.imagesBaseURL
                url = url.appendingPathComponent(urlString)
                self?.bakcDrop.kf.indicatorType = .activity
                self?.bakcDrop.kf.setImage(with: url)
            }else {
                print("no image")
            }
        }).disposed(by: disposeBag)
        
        viewModel?.rating.asObservable().bind(onNext: {[weak self] (value) in
            if let rating = value {
                print(rating)
                self?.ratingBar.progress = rating / 10
                self?.rate.text = "\(rating / 10)"
            }
        }).disposed(by: disposeBag)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

