//
//  Constant.swift
//  MovieDB
//
//  Created by MacBook on 10/01/22.
//

import Foundation

public class Constant{
    public static var baseUrl: String{
        return Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    }
    
    public static var imageBaseUrl: String{
        return Bundle.main.infoDictionary?["IMAGE_BASE_URL"] as? String ?? ""
    }
    
    public static var apiKey: String{
        return Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    }

}
