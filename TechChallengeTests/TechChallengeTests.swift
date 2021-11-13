//
//  TechChallengeTests.swift
//  TechChallengeTests
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

import XCTest
@testable import TechChallenge

class TransactionPresenterTest: XCTestCase {

    // filtering of transactions according to category
    func testFilterCategories() throws {
        let presenter = TransactionPresenter(transactions: ModelData.sampleTransactions,
                                             selected: nil)
        XCTAssertEqual(presenter.viewModel.transactions.count, ModelData.sampleTransactions.count)
        
        TransactionModel.Category.allCases.forEach { category in
            presenter.viewModel.didSelected(category)
            let filtered = ModelData.sampleTransactions.filter { $0.category == category }
            XCTAssertEqual(presenter.viewModel.transactions.count, filtered.count)
            XCTAssert(presenter.viewModel.transactions.allSatisfy { $0.transaction.category == category })
        }
    }
    
    // Sum of transaction amounts for filtered category
    func testTransactionAmmount() throws {
        let presenter = TransactionPresenter(transactions: ModelData.sampleTransactions,
                                             selected: nil)
        XCTAssertEqual(presenter.viewModel.transactions.count, ModelData.sampleTransactions.count)
        
        TransactionModel.Category.allCases.forEach { category in
            presenter.viewModel.didSelected(category)
            let filtered = ModelData.sampleTransactions.filter { $0.category == category }
            XCTAssertEqual(presenter.viewModel.prices, filtered.amount())
        }
        
        presenter.viewModel.didSelected(.food)
        XCTAssertEqual(presenter.viewModel.prices,74.28)
    }
}
