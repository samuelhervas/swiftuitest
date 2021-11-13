import Combine

final class TransactionPresenter {
    
    var viewModel: TransactionListViewModel!
    
    @DistinctEnvironmentObject(\.pinned) var pinnedService: PinnedService
    
    private static var categories: [TransactionModel.Category] = TransactionModel.Category.allCases
    private var transactionsModel: [TransactionModel]
    private var selected: TransactionModel.Category?
    
    init(transactions: [TransactionModel],
         selected: TransactionModel.Category?) {
        self.transactionsModel = transactions
        self.viewModel = buildViewModel()
    }
    
    private func updateTransactions() {
        let transactions = filterTransactions()
        let transactionsViewModel: [TransactionViewModel] = transactionViewModel(transactions: transactions)
        let prices = transactions.filter({ !pinnedService.pinnedTransactions.contains($0) }).amount()
        viewModel.transactions = transactionsViewModel
        viewModel.prices = prices
    }
    
    private func didUpdate(transaction: TransactionModel) {
        var pinned = pinnedService.pinnedTransactions
        if pinned.contains(transaction) {
            pinned.remove(transaction)
        } else {
            pinned.insert(transaction)
        }
        pinnedService.pinnedTransactions = pinned
        updateTransactions()
    }
    
    private func didSelect(category: TransactionModel.Category?) {
        selected = category
        viewModel.selected = category
        updateTransactions()
    }
    
    private func pill()-> [Pill] {
        [Pill(color: .black, text: "all")] + TransactionPresenter.categories.map { Pill(color: $0.color, text: $0.rawValue) }
    }
    
    private func filterTransactions()-> [TransactionModel] {
        selected.flatMap { category in transactionsModel.filter { $0.category ==  category } } ?? transactionsModel
    }
    private func transactionViewModel(transactions: [TransactionModel])-> [TransactionViewModel] {
        transactions.map { TransactionViewModel(pinned: pinnedService.pinnedTransactions.contains($0), transaction: $0, action: {
            self.didUpdate(transaction: $0)
        })
        }
    }
    
    func buildViewModel()-> TransactionListViewModel {
        let transactions = filterTransactions()
        let transactionsViewModel: [TransactionViewModel] = transactionViewModel(transactions: transactions)
        let prices = transactions.amount()
        return TransactionListViewModel(pills: pill(), transactions: transactionsViewModel, selected: selected, prices: prices) { category in
            self.didSelect(category: category)
        }
    }
    
}
