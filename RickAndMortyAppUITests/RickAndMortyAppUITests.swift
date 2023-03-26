//
//  RickAndMortyAppUITests.swift
//  RickAndMortyAppUITests
//
//  Created by Glauber Gustavo on 23/03/23.
//

import XCTest
@testable import RickAndMortyApp

final class RickAndMortyAppUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testInitializingApp_ShouldShowCellsFromCollectionView() {
        let app = XCUIApplication()
        app.launch()
        let collectionViewsQuery = app.collectionViews.element
        
        let cellCount = collectionViewsQuery.cells.count
        XCTAssertGreaterThan(cellCount, 0)
    }
    
    func testInitializingApp_ShouldShowCollectionView() {
        
        let app = XCUIApplication()
        app.launch()
        let collectionViewsQuery = app.collectionViews.element
        
        XCTAssertTrue(collectionViewsQuery.exists)
        XCTAssertTrue(collectionViewsQuery.isHittable)
    }
    
    func testInitializingApp_ShouldShowLastCell() {
        
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = app.collectionViews
        let cellCount = collectionViewsQuery.cells.count
        let lastCellIndex = cellCount - 1
        let lastCell = collectionViewsQuery.cells.element(boundBy: lastCellIndex)
        
        XCTAssertTrue(lastCell.exists)
        XCTAssertTrue(lastCell.isHittable)
    }
    
    func testInitializingApp_ShouldHideActivityIndicator() {
        
        let app = XCUIApplication()
        app.launch()
        
        let loading = app.activityIndicators["In progress"]
        
        XCTAssertFalse(loading.exists)
    }
    
    func testUsingApp_ShouldSelectCharacter() {
        
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        
        let imageCharacter = app.windows.children(matching: .other).element
                                        .children(matching: .other).element
                                        .children(matching: .other).element
                                        .children(matching: .other).element
                                        .children(matching: .other).element
                                        .children(matching: .other).element
                                        .children(matching: .other).element
                                        .children(matching: .image).element
        
        XCTAssertTrue(imageCharacter.exists)
                
    }

    func testCharactersDetails_ImageZoom_ShouldIncreaseImageSizeWhenSelected() {
        
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        
        let characterDetails = app.windows.children(matching: .other).element
                                          .children(matching: .other).element
                                          .children(matching: .other).element
                                          .children(matching: .other).element
                                          .children(matching: .other).element
                                          .children(matching: .other).element
        
        let backgroundImageZoom = characterDetails.children(matching: .other).element
        let characterImage = backgroundImageZoom.children(matching: .image).element
        characterImage.tap()
        characterDetails.tap()
        
        let DetailsView = characterDetails.children(matching: .other).element(boundBy: 0)
        
        XCTAssertTrue(DetailsView.exists)
        XCTAssertTrue(DetailsView.isHittable)
    }
    
    func testCharactersDetails_BackButton_ShouldReturnToPreviousScreen() {
        
        let app = XCUIApplication()
        app.launch()
        let threeCell = app.collectionViews.children(matching: .cell).element(boundBy: 3)
                                           .children(matching: .other).element
                                           .children(matching: .other).element
                                           .children(matching: .other).element
        threeCell.tap()
        let characterDetails = app.windows.children(matching: .other).element
                                          .children(matching: .other).element
                                          .children(matching: .other).element
                                          .children(matching: .other).element
                                          .children(matching: .other).element
                                          .children(matching: .other).element
        let backButton = characterDetails.children(matching: .button).element
        backButton.tap()
        
        XCTAssertTrue(threeCell.exists)
        XCTAssertTrue(threeCell.isHittable)
    }
}
