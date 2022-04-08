//
//  SolidsTests.swift
//
//  Created by Asad Hayat on 09/03/2022.
//

import XCTest
@testable import Cars

class SolidsTests: XCTestCase {
    
    func test_api_valid_baseUrl(){
        // Arrangment
        let remoteRepo = RemoteRespository()
        // Action
        let baseUrl = remoteRepo.preparaBaseUrl()
        // Assertions
        XCTAssertNotNil(baseUrl)
    }
    
    func test_api_valid_reponse(){
        // Arrangment
        let expectation = self.expectation(description: "valid_response_returned")
        let remoteRepo = RemoteRespository()
        // Action
        remoteRepo.getAll { result in
            switch result{
            case .success(let responseModel):
                // Assertions
                XCTAssertNotNil(responseModel)
                XCTAssert((responseModel as Any) is [Article])
                expectation.fulfill()
            case .failure(_):
                XCTExpectFailure("Remote data fetch failed.")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
