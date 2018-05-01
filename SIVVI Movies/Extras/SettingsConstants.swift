//
//  SettingsConstants.swift
//  SIVVI Movies
//
//  Created by Zouhair on 4/30/18.
//  Copyright © 2018 Zouhair. All rights reserved.
//

import Foundation

class SettingsConstants {
    
    static var isProd = false
    static let endPoint = "/3"
    static let stagingStringBaseUrl = "https://api.themoviedb.org"
    static let prodStringBaseUrl = "https://api.themoviedb.org"
    
    static let apiKey = "92902f3b6e447dc1b5ae67621de4db57"
    
    static var urlString:String {
        return SettingsConstants.isProd ?
            SettingsConstants.prodStringBaseUrl + SettingsConstants.endPoint:
            SettingsConstants.stagingStringBaseUrl + endPoint
    }
    
    static var baseURL : URL {
        return URL(string: SettingsConstants.urlString)!
    }
    
    static var baseUrlString : String {
        return SettingsConstants.isProd ?
            SettingsConstants.prodStringBaseUrl :
            SettingsConstants.stagingStringBaseUrl
    }
}
