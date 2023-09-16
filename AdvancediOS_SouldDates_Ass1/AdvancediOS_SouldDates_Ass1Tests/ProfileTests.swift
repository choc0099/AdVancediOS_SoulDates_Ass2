//
//  ProfileTests.swift
//  AdvancediOS_SouldDates_Ass1Tests
//
//  Created by Christopher Averkos on 1/9/2023.
//

import XCTest
@testable import AdvancediOS_SouldDates_Ass1
//import DateManager 

final class ProfileTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUnderAge() throws {
        
        let underAgeBirthDate: Date = DateManager.setDate(day: 22, month: 05, year: 2010)!
        print(underAgeBirthDate)
        XCTAssertEqual(DateManager.isUnderAge(birthDate: underAgeBirthDate), true)
    }
    
    func testAppropriateAge() throws {
        let appropriateAge: Date = DateManager.setDate(day: 13, month: 06, year: 2002)!
        print(appropriateAge)
        XCTAssertEqual(DateManager.isUnderAge(birthDate: appropriateAge), false)
    }
    
    func testInValidIdNumber() throws {
        var proofOfAgeVM: UpdateProofOfAgeViewModel = UpdateProofOfAgeViewModel()
        proofOfAgeVM.dateOfBirth = DateManager.setDate(day: 24, month: 05, year: 1997)!
        proofOfAgeVM.proofOfAgeIdNumber = "smoked"
        
        XCTAssertThrowsError(try proofOfAgeVM.validate()) {
            error in
            XCTAssertTrue(error is ProfileError)
        }
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
