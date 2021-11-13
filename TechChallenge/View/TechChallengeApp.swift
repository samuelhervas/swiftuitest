//
//  TechChallengeApp.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

@main
struct TechChallengeApp: App {
    
    let presenter = TransactionPresenter(transactions: ModelData.sampleTransactions,
                                         selected: nil)
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    TransactionListView(viewModel: presenter.viewModel)
                }
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                
                NavigationView {
                    InsightsView(insightsViewModel: InsightsPresenter().viewModel)
                }
                .tabItem {
                    Label("Insights", systemImage: "chart.pie.fill")
                }
            }
        }
    }
}
