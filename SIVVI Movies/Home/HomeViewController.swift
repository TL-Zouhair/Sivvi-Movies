//
//  HomeViewController.swift
//  SIVVI Movies
//
//  Created by Zouhair on 4/30/18.
//  Copyright © 2018 Zouhair. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController {
    var homeViewModel:HomeViewModel!
    
    override func viewDidLoad() {
        homeViewModel = HomeViewModel()
        homeViewModel.getSections(page: 1, sort_by: "popularity.desc")
    }
}

