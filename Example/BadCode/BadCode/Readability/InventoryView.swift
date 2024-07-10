//
//  InventoryView.swift
//  BadCode
//
//  Created by Matheus Gois on 08/07/24.
//

import SwiftUI



struct invView: View{
    private let c = "$" // currency
    @State private var _i = [ // inventory
        1: invItem(pdt: "Flashlight", img: "placeholder",
                   desc: "A really great flashlight", price: 100, c: "usd"),
        2: invItem(pdt: "Tin can", img: "placeholder", 
                   desc: "Pretty much what you would expect from a tin can", price: 32, c: "usd"),
        3: invItem(pdt: "Cardboard Box", img: "placeholder", 
                   desc: "It holds things", price: 5, c: "usd")
    ]



    var body:some View {
        List {
          ForEach(_i.keys.sorted(), id: \.self) { key in
                let i = self._i[key]!
                HStack {
                    Image(i.img)
                        .resizable().frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(i.pdt).bold()
                        Text(i.desc)
                    }

                    Spacer()
                    Text(
                        "\(c) \(i.price)"
                    )
                }
        }}.listStyle(PlainListStyle())
  }
}



// InventoryItem model
struct invItem {

    var pdt: String ,img: String, desc: String


    var price: Int

    var c: String
}

// Preview
struct invView_Previews: PreviewProvider {
    static var previews: some View {
        invView()
    }
}
