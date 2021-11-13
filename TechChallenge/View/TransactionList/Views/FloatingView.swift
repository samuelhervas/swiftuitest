import SwiftUI

struct FloatingView: View  {
    
    var category: Binding<TransactionModel.Category?>
    
    @Binding var price: Double
    
    var body: some View {
        HStack {
            VStack(alignment: .trailing) {
                HStack {
                    Text(category.wrappedValue?.rawValue ?? "all")
                        .foregroundColor(category.wrappedValue?.color ?? .black)
                        .font(.headline)
                }
                HStack {
                    Text("Total spent")
                        .secondary()
                    Spacer()
                    Text("$\(price.formatted())")
                        .bold()
                        .secondary()
                }.frame(maxWidth: .infinity)
            }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.accentColor, lineWidth: 2)
            )
        }.padding(EdgeInsets(top: 3, leading: 5, bottom: 5, trailing: 5))
    }
}
