//
//  FirebaseTests.swift
//  StubetTests
//
//  Created by Pro on 2024/09/05.
//

import XCTest
import FirebaseCore
import FirebaseFirestore
@testable import Stubet

final class FirebaseTests: XCTestCase {

    override class func setUp() {
        super.setUp()
        // クラスのセットアップで一度だけ初期化
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }

    func testFirebaseConnection() {
        print("Starting Firebase connection test...")
        
        let expectation = self.expectation(description: "Firestore operation")
        
        let db = Firestore.firestore()
        db.collection("test").addDocument(data: ["hello": "world"]) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document successfully added!")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
