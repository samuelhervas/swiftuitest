import SwiftUI

struct TransactionListView: View {
    
    @ObservedObject var viewModel: TransactionListViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HorizontalList(items: viewModel.pills, selected: { pill in
                    viewModel.didSelected(TransactionModel.Category.init(rawValue: pill.text))
                }).background(Color.accentColor.opacity(0.8))
                List {
                    ForEach(viewModel.transactions) {
                        TransactionView(transactionViewModel: $0)
                    }
                }
                .animation(.easeIn)
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Transactions")
                
                FloatingView(category: $viewModel.selected, price: $viewModel.prices)
            }
            
        }
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = TransactionPresenter(transactions: ModelData.sampleTransactions,
                                  selected: nil)
        TransactionListView(viewModel: presenter.viewModel)
    }
}
#endif
