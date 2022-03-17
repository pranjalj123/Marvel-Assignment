//
//  CharacterDetailTestCases.swift
//  Marvel AppTests
//
//  Created by admin on 3/17/22.
//


import XCTest


class CharacterDetailTestCases : XCTestCase {
    
    var characterModel : CharacterModel?
    var errorModel : ErrorModel?
    
    private var publicKey = getPublicPrivateKeys()[Constants.publicKey.rawValue] ?? ""
    private var privateKey = getPublicPrivateKeys()[Constants.privateKey.rawValue] ?? ""
    
    //MARK: Test character detail API resource with empty string and return error
    func testCharacterDetailAPIResourceWithEmptyStringReturnsError() {
        let expectation = self.expectation(description: "emptyString")
        let url = "\(baseUrl)characters/?ts=&apikey=&hash="
        APIClass.init().getRequest(url: url) { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.code, "ResourceNotFound")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test character detail API resource with invalid parameters and returns error
    func testCharacterDetailApiResourceWithInvalidHashParameterReturnError() {
        let expectation = self.expectation(description: "invalid")
        let url = "\(baseUrl)characters/-1?ts=22222&apikey=sdfdsfssd&hash=4r4r4rss"
        APIClass.init().getRequest(url: url) { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "The passed API key is invalid.")
            XCTAssertEqual(self.errorModel?.code, "InvalidCredentials")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test character detail API resource with missing time stamp and returns error
    func testCharacterDetailApiResourcesWithMissingReturnsError() {
        let expectation = self.expectation(description: "missingTimeStamp")
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters/1011334?apikey=\(publicKey)&hash=\(hash)"
        APIClass.init().getRequest(url: url) { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "You must provide a timestamp.")
            XCTAssertEqual(self.errorModel?.code, "MissingParameter")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test character detail API resource with valid parameters and correct response
    func testCharacterDetailApiResourceWithValidHashParametersReturnsCorrectResponse() {
        let expectation = self.expectation(description: "testCHaracterListApiResourceWithvalidHashParametersReturnsCorrectResponse")
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters/1011334?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        APIClass.init().getRequest(url: url) { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.characterModel = try? jsonDecoder.decode(CharacterModel.self, from: jsonData!)
            XCTAssertNotNil(self.characterModel?.data?.results)
            XCTAssertEqual(self.characterModel?.status, "Ok")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
