//
//  UserDetailViewModelTests.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 04/07/25.
//

import XCTest
@testable import GithubUsers

@MainActor
final class UserDetailViewModelTests: XCTestCase {
    
    var viewModel: UserDetailViewModel!
    var mockNetworkService: MockUserDetailNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockUserDetailNetworkService()
        viewModel = UserDetailViewModel(networkService: mockNetworkService, id: "TestUserID")
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testUserIDInitialization() {
        // Then
        XCTAssertEqual(viewModel.userID, "TestUserID")
    }
    
    func testFetchUserDetails_Success() async {
        // Given
        let expectedUser = UserDetailModel(id: 1, login: "TestUser", avatarUrl: "", name: "Test User", bio: "Test Bio")
        let expectedRepos = [UserRepositoryModel(id: 1, name: "Repo1", description: "Repo Description")]
        
        mockNetworkService.mockUserDetail = expectedUser
        mockNetworkService.mockUserRepos = expectedRepos
        
        // When
        await viewModel.fetchUserDetails()
        
        // Then
        XCTAssertNotNil(viewModel.userDetailModel)
        XCTAssertEqual(viewModel.userDetailModel?.login, "TestUser")
        XCTAssertEqual(viewModel.userRepos.count, 1)
        XCTAssertEqual(viewModel.userRepos.first?.name, "Repo1")
    }
    
    func testFetchUserDetails_Failure() async {
        // Given
        mockNetworkService.shouldReturnError = true
        
        // When
        await viewModel.fetchUserDetails()
        
        // Then
        XCTAssertNil(viewModel.userDetailModel)
        XCTAssertTrue(viewModel.userRepos.isEmpty)
    }
}
