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
    public static func search(domain:String, completion: ((Swift.Error?, [[String: Any]]?) -> Void)?) {
        Alamofire.request("https://api.onuniverse.com/v1/domains/search",
                          method:.post,
                          parameters: [ "domain":domain],
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type" : "application/json"]
                          )
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let response = response.result.value as? [String: Any]
                    if response != nil {
                        let domains = response!["status"] as? [[String: Any]]
                        if domains == nil {
                            print ("Json format is corrupted")
                            completion?(nil, nil)
                            return
                        }
                        completion?(nil, domains)
                        print("Validation Successful")
                    }
                    
                case .failure(let error):
                    completion?(error, nil)
                    print(error)
                }
        }
    }
}
