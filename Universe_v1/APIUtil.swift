//
//  APIUtil.swift
//  Universe_v1
//
//  Created by Cezar Babin on 4/21/17.
//  Copyright © 2017 Cezar Babin. All rights reserved.
//

import UIKit
import Alamofire

class APIUtil: NSObject {
    public static func search(domain:String) {
        Alamofire.request("https://api.onuniverse.com/v1/domains/search",
                          method:.post,
                          parameters: [ "domain":domain],
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type" : "application/json"]
                          )
            .validate()
            .responseJSON { response in
                debugPrint("Response: \(response)")
        }
    }
}
