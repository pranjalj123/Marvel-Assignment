//
//  Marvel_AppTests.swift
//  Marvel AppTests
//
//  Created by admin on 3/13/22.
//

import XCTest
@testable import Marvel_App
import UIKit

class CharacterListTestCases: XCTestCase {

    var characterModel : CharacterModel?
    var errorModel : ErrorModel?
    private var publicKey = getPublicPrivateKeys()[Constants.publicKey.rawValue] ?? ""
    private var privateKey = getPublicPrivateKeys()[Constants.privateKey.rawValue] ?? ""
    
    //MARK: Test Character API resource with empty string and return error
    func testCharacterListApiResourceWithEmptyStringReturnsError() {
        let expectation = self.expectation(description: "emptyString")
        let url = "\(baseUrl)characters?ts=&apikey=&hash="
        APIClass.init().getRequest(url: url) { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "The passed API key is invalid.")
            XCTAssertEqual(self.errorModel?.code, "InvalidCredentials")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test Character List API Resource With Invalid Hash Parameters and returns error
    func testCharacterListApiResourceWithInvalidHashParametersReturnsError() {
        let expectation = self.expectation(description: "invalidHash")
        let url = "\(baseUrl)characters?ts=22222&apikey=nfjndjfjdjf&hash=4r4r4rr44r"
        APIClass.init().getRequest(url: url) { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "The passed API key is invalid.")
            XCTAssertEqual(self.errorModel?.code, "InvalidCredentials")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test character list API resource with missing timestamp and returns error
    func testCharacterListResourcesWithMissingReturnsError() {
        let expectation = self.expectation(description: "missedTimeStamp")
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters?apikey=\(publicKey)&hash=\(hash)"
        APIClass.init().getRequest(url: url) { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "You must provide a timestamp.")
            XCTAssertEqual(self.errorModel?.code, "MissingParameter")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test character list API resources with valid parameters and returns correct response
    func testCHaracterListApiResourceWithValidHashParametersReturnsCorrectResponse() {
        let expectation = self.expectation(description: "validParameters")
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        APIClass.init().getRequest(url: url) { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.characterModel = try? jsonDecoder.decode(CharacterModel.self, from: jsonData!)
            XCTAssertNotNil(self.characterModel?.data?.results)
            XCTAssertEqual(self.characterModel?.status, "Ok")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
