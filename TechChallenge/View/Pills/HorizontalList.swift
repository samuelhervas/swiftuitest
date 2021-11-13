import SwiftUI

struct HorizontalList: View {
    let items: [Pill]
    let selected: (Pill)-> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (alignment: .center, spacing: 20){
                ForEach(items, id: \.text) { item in
                    PillView(text: item.text, color: item.color) {
                        selected(item)
                    }
                }
            }.padding()
        }
    }
}
