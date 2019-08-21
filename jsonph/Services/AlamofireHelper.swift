//
//  AlamofireHelper.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireHelper {
    // Requête pour un endpoint donné
    static func request(baseUrl: URL, endpoint: Endpoint) -> Alamofire.DataRequest {
            
        let url = baseUrl.appendingPathComponent(endpoint.path)
        
        var encoding: ParameterEncoding = JSONEncoding.default
        if (endpoint.method == .get) {
            encoding = URLEncoding.default
        }
        
        return Alamofire.request(url, method: endpoint.method, parameters: endpoint.parameters, encoding: encoding)
    }
}

