//
//  UserListViewModelTests.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 04/07/25.
//

import XCTest
@testable import GithubUsers

@MainActor
final class UserListViewModelTests: XCTestCase {
    
    var viewModel: UserListViewModel!
    var mockNetworkService: MockUserListNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockUserListNetworkService()
        viewModel = UserListViewModel(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchUsers_Success() async {
        debugPrint("🔍 Test started")
        
        // Given
        let dummyUsers = [UserModel(id: 1, login: "User1"),
                          UserModel(id: 2, login: "User2")]
        mockNetworkService.mockUsers = dummyUsers
        
        // When
        let success = await viewModel.fetchUsers()
        
        // Then
        XCTAssertTrue(success)
        XCTAssertEqual(viewModel.users.count, 2)
        XCTAssertEqual(viewModel.users.first?.login, "User1")
        
        debugPrint("✅ Test finished")
    }
    
    func testFetchUsers_Failure() async {
        // Given
        mockNetworkService.shouldReturnError = true
        
        // When
        let success = await viewModel.fetchUsers()
        
        // Then
        XCTAssertFalse(success)
        XCTAssertEqual(viewModel.users.count, 0)
    }
    
    func testSearchUsers_Success() async {
        // Given
        let searchUsers = [UserModel(id: 3, login: "SearchUser")]
        mockNetworkService.mockSearchResult = SearchModel(users: searchUsers)
        
        // When
        await viewModel.searchUsers(with: "Search")
        
        // Then
        XCTAssertEqual(viewModel.searchedUsers.count, 1)
        XCTAssertEqual(viewModel.searchedUsers.first?.login, "SearchUser")
    }
    
    func testResetPage() {
        // Given
        let dummyUsers = [UserModel(id: 1, login: "Test")]
        let dummySearchedUsers = [UserModel(id: 2, login: "TestSearch")]
        
        viewModel.setupDummyData(users: dummyUsers, searchedUsers: dummySearchedUsers, currentPage: 0)
        
        // When
        viewModel.resetPage()
        
        // Then
        XCTAssertEqual(viewModel.users.count, 0)
        XCTAssertEqual(viewModel.searchedUsers.count, 0)
    }
}
