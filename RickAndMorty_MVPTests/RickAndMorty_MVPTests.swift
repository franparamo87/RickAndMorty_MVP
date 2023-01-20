//
//  RickAndMorty_MVPTests.swift
//  RickAndMorty_MVPTests
//
//  Created by Fran on 18/1/23.
//

import XCTest
@testable import RickAndMorty_MVP

class RickAndMorty_MVPTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetAllCharacters() throws {
        let services = RickMortServices.shared
        let promise = expectation(description: "Call API success")
        services.getAllCharacters { characters in
            promise.fulfill()
        } failureHandler: { error in
            print(error)
            return
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetCharactersbyIds() throws {
        let services = RickMortServices.shared
        let promise = expectation(description: "Call API success")
        services.getCharacters([1,2]) { characters in
            promise.fulfill()
        } failureHandler: { error in
            print(error)
            return
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetCharactersbyIdsError() throws {
        let services = RickMortServices.shared
        let promise = expectation(description: "Call API failure by array ids empty")
        services.getCharacters([]) { _ in
            return
        } failureHandler: { error in
            print(error)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetAllEpisodes() throws {
        let services = RickMortServices.shared
        let promise = expectation(description: "Call API success")
        services.getAllEpisodes { episodes in
            promise.fulfill()
        } failureHandler: { error in
            print(error)
            return
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetEpisodesbyIds() throws {
        let services = RickMortServices.shared
        let promise = expectation(description: "Call API success")
        services.getEpisodes([1,2]) { episodes in
            promise.fulfill()
        } failureHandler: { error in
            print(error)
            return
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetEpisodesbyIdsError() throws {
        let services = RickMortServices.shared
        let promise = expectation(description: "Call API failure by array ids empty")
        services.getEpisodes([]) { _ in
            return
        } failureHandler: { error in
            print(error)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetLocationsByIds() throws {
        let services = RickMortServices.shared
        let promise = expectation(description: "Call API success")
        services.getLocations([1,2]) { locations in
            promise.fulfill()
        } failureHandler: { error in
            print(error)
            return
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetLocationsByIdsError() throws {
        let services = RickMortServices.shared
        let promise = expectation(description: "Call API failure by array ids empty")
        services.getLocations([]) { _ in
            return
        } failureHandler: { error in
            print(error)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
