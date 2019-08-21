//
//  User.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

// Note : n'ayant pas trouvé de swagger pour la description des API de JSONPlaceholder,
//   je suis parti du principe que l'ensemble des attributs JSON non sensibles sont optionnels.
//   C'est moins joli à voir, mais c'est moins risqué.

// MARK: - User
struct User {
    var id: Int
    var name: String?
    var username: String?
    var email: String?
    var address: UserAddress?
    var phone: String?
    var website: String?
    var company: UserCompany?
}

extension User {
//    init(id: Int, name: String?, username: String?, email: String?, address: UserAddress?, phone: String?, website: String?, company: UserCompany?) {
//        self.id = id
//        self.name = name
//        self.username = username
//        self.email = email
//        self.address = address
//        self.phone = phone
//        self.website = website
//        self.company = company
//    }
    
    init(with json: JSON) {
        self.id = json["id"] as! Int
        self.name = json["name"] as? String
        self.username = json["username"] as? String
        self.email = json["email"] as? String
        self.phone = json["phone"] as? String
        self.website = json["website"] as? String
        
        if let addressJson = json["address"] as? JSON {
            self.address = UserAddress(with: addressJson)
        }
        if let companyJson = json["company"] as? JSON {
            self.company = UserCompany(with: companyJson)
        }
    }
}

// MARK:- UserAdress
struct UserAddress {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: UserGeo?
}

extension UserAddress {
    init(with json: JSON) {
        self.street = json["street"] as? String
        self.suite = json["suite"] as? String
        self.city = json["city"] as? String
        self.zipcode = json["zipcode"] as? String
        
        if let geoJson = json["geo"] as? JSON {
            self.geo = UserGeo(with: geoJson)
        }
    }
}


// MARK:- UserCompany
struct UserCompany {
    var name: String?
    var catchPhrase: String?
    var bs: String?
}

extension UserCompany {
    init(with json: JSON) {
        self.name = json["name"] as? String
        self.catchPhrase = json["catchPhrase"] as? String
        self.bs = json["bs"] as? String
    }
}

// MARK:- UserGeo
struct UserGeo {
    var lat: String?
    var lng: String?
}

extension UserGeo {
    init(with json: JSON) {
        self.lat = json["lat"] as? String
        self.lng = json["lng"] as? String
    }
}
