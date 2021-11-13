import Foundation

final class InsightsPresenter {
    
    var viewModel: InsightsViewModel = InsightsViewModel(categories: TransactionModel.Category.allCases,
                                                         transactions: ModelData.sampleTransactions)
    
    
}
