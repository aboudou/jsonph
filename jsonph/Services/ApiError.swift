//
//  ApiError.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

enum ApiError: String {
    case otherError  = "An error has occured, please retry later"  // Erreur réseau, serveur, etc.
    case invalidJson = "The response is invalid"                   // JSON invalide
}
