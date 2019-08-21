//
//  jsonphTests.swift
//  jsonphTests
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import XCTest
@testable import jsonph

class UserTests: XCTestCase {
    
    var user1: User!
    var user2: User!
    var userList = [User]()

    override func setUp() {
        let user1Geo = UserGeo(lat: "-37.3159",
                               lng: "81.1496")

        let user1Address = UserAddress(street: "Kulas Light",
                                       suite: "Apt. 556",
                                       city: "Gwenborough",
                                       zipcode: "92998-3874",
                                       geo: user1Geo)

        let user1Company = UserCompany(name: "Romaguera-Crona",
                                       catchPhrase: "Multi-layered client-server neural-net",
                                       bs: "harness real-time e-markets")
        user1 = User(id: 1,
                     name: "Leanne Graham",
                     username: "Bret",
                     email: "Sincere@april.biz",
                     address: user1Address,
                     phone: "1-770-736-8031 x56442",
                     website: "hildegard.org",
                     company: user1Company)
        
        userList.append(user1)
        
        
        
        let user2Geo = UserGeo(lat: "-43.9509",
                               lng: "-34.4618")

        let user2Address = UserAddress(street: "Victor Plains",
                                       suite: "Suite 879",
                                       city: "Wisokyburgh",
                                       zipcode: "90566-7771",
                                       geo: user2Geo)
        
        let user2Company = UserCompany(name: "Deckow-Crist",
                                       catchPhrase: "Proactive didactic contingency",
                                       bs: "synergize scalable supply-chains")
        
        user2 = User(id: 2,
                     name: "Ervin Howell",
                     username: "Antonette",
                     email: "Shanna@melissa.tv",
                     address: user2Address,
                     phone:"010-692-6593 x09125",
                     website: "anastasia.net",
                     company: user2Company)

        userList.append(user2)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSON2User() {
        let jsonString = """
        [
            {
                \"id\": 1,
                \"name\": \"Leanne Graham\",
                \"username\": \"Bret\",
                \"email\": \"Sincere@april.biz\",
                \"address\": {
                    \"street\": \"Kulas Light\",
                    \"suite\": \"Apt. 556\",
                    \"city\": \"Gwenborough\",
                    \"zipcode\": \"92998-3874\",
                    \"geo\": {
                        \"lat\": \"-37.3159\",
                        \"lng\": \"81.1496\"
                    }
                },
                \"phone\": \"1-770-736-8031 x56442\",
                \"website\": \"hildegard.org\",
                \"company\": {
                    \"name\": \"Romaguera-Crona\",
                    \"catchPhrase\": \"Multi-layered client-server neural-net\",
                    \"bs\": \"harness real-time e-markets\"
                }
            },
            {
                \"id\": 2,
                \"name\": \"Ervin Howell\",
                \"username\": \"Antonette\",
                \"email\": \"Shanna@melissa.tv\",
                \"address\": {
                    \"street\": \"Victor Plains\",
                    \"suite\": \"Suite 879\",
                    \"city\": \"Wisokyburgh\",
                    \"zipcode\": \"90566-7771\",
                    \"geo\": {
                        \"lat\": \"-43.9509\",
                        \"lng\": \"-34.4618\"
                    }
                },
                \"phone\": \"010-692-6593 x09125\",
                \"website\": \"anastasia.net\",
                \"company\": {
                    \"name\": \"Deckow-Crist\",
                    \"catchPhrase\": \"Proactive didactic contingency\",
                    \"bs\": \"synergize scalable supply-chains\"
                }
            }
        ]
        """
        
        do {
            if let json = jsonString.data(using: String.Encoding.utf8) {
                if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [[String: Any]] {
                    let users = jsonData.map({User(with: $0)})
                    
                    XCTAssert(users.count == 2, "Users count should be '2', '\(users.count)' found")
                    XCTAssert(users[0].email == "Sincere@april.biz", "Email should be 'Sincere@april.biz', '\(users[0].email!)' found")
                    XCTAssert(users[1].address?.geo?.lat == "-43.9509", "Lat should be '-43.9509', '\(users[1].address!.geo!.lat!)' found")
                    
                } else {
                    XCTFail("JSON Serialization error")
                }
            } else {
                XCTFail("JSON Serialization error")
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testUserList2UserListVM() {
        let userListVM = UserListVM(users: self.userList)
        
        XCTAssert(userListVM.users.count == 2, "Users count should be '2', '\(userListVM.users.count)' found")
        XCTAssert(userListVM.users[0].email == "Sincere@april.biz", "Email should be 'Sincere@april.biz', '\(userListVM.users[0].email!)' found")
        XCTAssert(userListVM.users[1].address?.geo?.lat == "-43.9509", "Lat should be '-43.9509', '\(userListVM.users[1].address!.geo!.lat!)' found")
    }
    
    func testUser2UserCellVM() {
        let userCellVM = UserCellVM(user1)
        
        XCTAssert(userCellVM.name == "Leanne Graham", "Name should be 'Leanne Graham', '\(userCellVM.name!)' found")
        XCTAssert(userCellVM.username == "@Bret", "Username should be '@Bret', '\(userCellVM.username!)' found")
    }

}
