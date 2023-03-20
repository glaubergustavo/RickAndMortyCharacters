//
//  HomePresenterTests.swift
//  RickAndMortyAppUITests
//
//  Created by Glauber Gustavo on 16/03/23.
//

import Foundation
import XCTest
@testable import RickAndMortyApp

private class HomeManagerServicingStub: HomeManagerServicing {
    
    var fetchHomePresenterResult: Result<Characters?, Error> = .success(Characters(info: Info(count: 826, pages: 42), results: []))

    func loadCharacters(page: Int, _ completion: @escaping (Result<Characters?, Error>) -> Void) {
        completion(fetchHomePresenterResult)
    }
}

private class HomePresenterDelegateSpy: HomePresenterDelegate {
    private(set) var showLoadingCount = 0
    private(set) var hideLoadingCount = 0
    private(set) var showCollectionViewCount = 0
    private(set) var callDataLoadedCount = 0
    private(set) var showNotFoundMessageCount = 0
    
    func dataLoaded() {
        callDataLoadedCount += 1
    }
    
    func showLoading(_ loading: Bool) {
        
        if loading == true {
            showLoadingCount += 1
        }else {
            hideLoadingCount += 1
        }
    }
    
    func showNotFoundMessage() {
        showNotFoundMessageCount += 1
    }
    
    func showCollectionView(_ show: Bool) {
        if show == true {
            showCollectionViewCount += 1
        }
    }
}

private struct ErrorDummy: Error { }

final class HomePresenterTests: XCTestCase {
    
    private var homePresenter: HomePresenter!
    private var homeManager: HomeManagerServicingStub!
    private var delegate: HomePresenterDelegateSpy!
    
    
    override func setUp() {
        super.setUp()
        
        homeManager = HomeManagerServicingStub()
        homePresenter = HomePresenter(homeManager: homeManager)
        delegate = HomePresenterDelegateSpy()
        
        homePresenter.delegate = delegate
    }
    
    override func tearDown() {
        super.tearDown()
        
        homePresenter = nil
        homeManager = nil
        delegate = nil
    }
    
    func testNumberOfRows_ShouldBeEqualToNumberOfCharactersOnList() {
        let location = Location(name: "", url: "")
        let character = Results(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: location, location: location, image: "", episode: [], url: "", created: "")
        let result = Characters(info: Info(count: 826, pages: 42), results: Array(repeating: character, count: 20))
        homeManager.fetchHomePresenterResult = .success(result)
        homePresenter.loadCharacters()
        
        XCTAssertEqual(20, homePresenter.numberOfRows)
    }
    
    func testCharacterForRow_ShouldReturnCharacterForRow() {
        let location = Location(name: "", url: "")
        let character = Results(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: location, location: location, image: "", episode: [], url: "", created: "")
        let characterToCompare = Results(id: 2, name: "", status: "", species: "", type: "", gender: "", origin: location, location: location, image: "", episode: [], url: "", created: "")
        let result = Characters(info: Info(count: 826, pages: 42), results: [character, characterToCompare])
        
        homeManager.fetchHomePresenterResult = .success(result)
        homePresenter.loadCharacters()
        
        XCTAssertEqual(characterToCompare, homePresenter.getCharacter(for: 1))
    }
    
    func testLoadCharacters_ShouldShowLoading() {
        homePresenter.loadCharacters()
        
        XCTAssertEqual(1, delegate.showLoadingCount)
    }
    
    func testLoadCharacters_ShouldHideLoading() {
        homePresenter.loadCharacters()
        
        XCTAssertEqual(1, delegate.hideLoadingCount)
    }
    
    func testLoadCharacters_ShouldShowCollectionView() {
        homePresenter.loadCharacters()
        
        XCTAssertEqual(1, delegate.showCollectionViewCount)
    }
    
    func testLoadCharacters_WhenSuccess_ShouldCallDataLoaded() {
        homePresenter.loadCharacters()
        
        XCTAssertEqual(1, delegate.callDataLoadedCount)
        XCTAssertEqual(0, delegate.showNotFoundMessageCount)
    }
    
    func testLoadCharacters_WhenFailure_ShouldCallshowNotFoundMessage() {
        homeManager.fetchHomePresenterResult = .failure(ErrorDummy())
        homePresenter.loadCharacters()
        
        XCTAssertEqual(1, delegate.showNotFoundMessageCount)
        XCTAssertEqual(0, delegate.callDataLoadedCount)
    }
    
    func testLoadMoreCharacters_ShouldFailCallToLoadCharacters_IndexConditionNotSatisfied() {
        
        homePresenter.page = 1
        homePresenter.loadMoreCharacters(at: homePresenter.numberOfRows - 2)

        XCTAssertEqual(homePresenter.page, 1)
    }
        
    func testLoadMoreCharacters_ShouldFailCallToLoadCharacters_CharactersTotalConditionNotSatisfied() {
                
        homePresenter.total = homePresenter.numberOfRows
        homePresenter.loadMoreCharacters(at: homePresenter.numberOfRows - 2)

        XCTAssertEqual(homePresenter.page, 1)
    }
    
    func testLoadMoreCharacters_ShouldCallLoadCharacters_ShouldIncrementThePage() {
        
        homePresenter.page = 1
        homePresenter.total = 50
        homePresenter.loadMoreCharacters(at: homePresenter.numberOfRows - 2)

        XCTAssertEqual(homePresenter.page, 2)
    }
}


