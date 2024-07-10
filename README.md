# 3 Rs of Software Architecture

![software architecture pyramid](https://github.com/MaatheusGois/3rs-of-software-architecture-for-iOS/assets/31082311/c21ae231-8908-47bc-9d44-2e6a32cd8603)

## Software Architecture

After over 50 years of software engineering, we still haven't settled on a precise definition of software architecture. It remains the art within computer science, persistently evading our efforts to pin it down. Nevertheless, its importance to the industry and applications is undeniable.

Despite this lack of consensus, numerous definitions bring us closer to formalizing software architecture. One of the most notable comes from the IEEE:

>"Architecture is the fundamental organization of a system embodied in its components, their relationships to each other, and to the environment, and the principles guiding its design and evolution." [IEEE 1471]

While this definition and others clarify the elements that constitute architecture, they don't provide a mental model for developing applications. This project aims to fill that gap. By focusing on three key "ilities"—readability, reusability, and refactorability—we can create a hierarchy of architectural attributes that offers a framework for thinking about system code and architecture. It won't provide a ready-made architecture, but it will guide you in determining what architecture works best for your iOS application.

## What is This Project?

This project serves as a guide to analyze three key "ilities" of software architecture—readability, reusability, and refactorability—and demonstrates how hierarchical thinking about these concepts can lead to better code. It is designed for developers of all skill levels, though beginners may find it particularly beneficial.

We will explore a simple `Shopping Cart` application written in Swift, utilizing the SwiftUI framework. Swift and SwiftUI are popular choices among both newcomers and seasoned developers, making them an excellent common language for discussing code quality.

Our application will be developed incrementally, with "Bad" vs. "Good" versions compared at each step within the 3R hierarchy. You can find all the code in the `Example` directory, along with instructions on how to build and develop the application at the end of this README.

It's important to note that this project is not the definitive way to approach software architecture, nor does it provide a complete architecture. However, it offers guidance to help shape your thinking, as it has shaped mine.

Without further ado, let's get started!

## 1. Readability

Readability is the simplest measure of code quality and the easiest to address. It is the first thing you notice when you open a piece of code and generally includes:

- Formatting
- Variable names
- Function names
- Number of function arguments
- Function length (number of lines)
- Nesting levels

These aren't the only factors, but they are immediate red flags. Fortunately, there are a few straightforward rules to follow to fix issues related to these aspects:

- **Invest in an automatic formatter:** Find one that your team agrees on and integrate it into your build process. Formatting arguments during code reviews waste time and money. In this project, we will use [SwiftFormat](https://github.com/nicklockwood/SwiftFormat).

- **Use meaningful and pronounceable variable/function names:** Code is for people, and only incidentally for computers. Naming is the most significant way to communicate the meaning behind your code.

- **Limit function arguments to between 1-3:** Zero arguments imply you're mutating state or relying on state from somewhere other than the caller. More than three arguments make the code hard to read and refactor due to the numerous paths the function can take.

- **Function length:** There is no set limit of lines for a function, as this depends on the language you're coding in. However, a function should do ONE thing and ONE thing only. For example, a function calculating an item's price after taxes should not also connect to a database, look up the item, and get the tax data. Long functions usually indicate that too much is happening.

- **Limit nesting levels:** More than two levels of nesting can imply poor performance (especially in loops) and can be hard to read in long conditionals. Consider extracting nested logic into separate functions.

Now, let's take a look at the first piece of our `Shopping Cart` application to see what poor readability looks like:

```swift
// Example/BadCode/BadCode/Readability/InventoryView.swift
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
```
There are a number of problems we can see right away:
* Inconsistent and unpleasant formatting
* Poorly named variables
* Disorganized data structures (inventory using a dictionary)
* Comments that are either unnecessary or serve the job of what a good variable name would
* Hardcoded values (currency symbol)
* Improper model definition (invItem should conform to Identifiable)
* Redundant code (currency property in invItem not used)
* Unnecessary forced unwrapping
* Improper list style selection

Let's take a look at how we could improve it:
```swift
// Example/GoodCode/GoodCode/Readability/Readability.InventoryView.swift

import SwiftUI

struct InventoryView: View {

    @State private var inventory = [
        InventoryItem(
            id: 0,
            product: "Flashlight",
            image: "placeholder",
            description: "A really great flashlight",
            price: 100,
            currency: .usd
        ),
        InventoryItem(
            id: 1,
            product: "Tin can",
            image: "placeholder",
            description: "Pretty much what you would expect from a tin can",
            price: 32,
            currency: .usd
        ),
        InventoryItem(
            id: 2,
            product: "Cardboard Box",
            image: "placeholder",
            description: "It holds things",
            price: 5,
            currency: .usd
        )
    ]

    var body: some View {
        List {
            ForEach(inventory) { item in
                HStack {
                    Image(item.image)
                        .resizable()
                        .frame(width: 50, height: 50)

                    VStack(alignment: .leading) {
                        Text(item.product)
                            .font(.headline)
                        Text(item.description)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(item.priceFormatted)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct InventoryItem: Identifiable {
    var id: Int
    var product: String
    var image: String
    var description: String
    var price: Int
    var currency: Currency

    var priceFormatted: String {
        "\(currency.symbol) \(price)"
    }
}

enum Currency {
    case usd

    var symbol: String {
        switch self {
        case .usd:
            return "$"
        }
    }
}
```
This improved code now exhibits the following features:
* It is consistently formatted using the automatic formatter [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)
* Names are much more descriptive
* Data structures are properly organized.
* Comments are no longer needed because good naming serves to clarify the meaning of the code. Comments are needed when business logic is complex and when documentation is required.

Too see more code improvements based on SOLID read: [clean-code-swift](https://github.com/MaatheusGois/clean-code-swift)

## 2. Reusability

Reusability is the sole reason you are able to read this code, communicate with strangers online, and even program at all. Reusability allows us to express new ideas with little pieces of the past.

That is why reusability is such an essential concept that should guide your software architecture. We commonly think of reusability in terms of DRY (Don't Repeat Yourself). That is one aspect of it -- don't have duplicate code if you can abstract it properly. Reusability goes beyond that though. It's about making clean, simple APIs that make your fellow progammer say, "Yep, I know exactly what that does!" Reusability makes your code a delight to work with, and it means you can ship features faster.

We will look at our previous example and expand upon it by adding a `Currency Converter` to handle our inventory's pricing in multiple countries:

```swift
// Example/GoodCode/GoodCode/Reusability/InventoryViewWithChoice.swift

import SwiftUI

struct InventoryViewWithChoice: View {

    @State private var localCurrency = Currency.usd

    @State private var inventory = [
        InventoryItem(
            id: 0,
            product: "Flashlight",
            image: "placeholder",
            description: "A really great flashlight",
            price: 100,
            currency: .usd
        ),
        InventoryItem(
            id: 1,
            product: "Tin can",
            image: "placeholder",
            description: "Pretty much what you would expect from a tin can",
            price: 32,
            currency: .usd
        ),
        InventoryItem(
            id: 2,
            product: "Cardboard Box",
            image: "placeholder",
            description: "It holds things",
            price: 5,
            currency: .usd
        )
    ]

    private let currencyConversions: [Currency: [Currency: Double]] = [
        .usd: [.usd: 1.0, .rupee: 66.78, .yuan: 6.87],
        .rupee: [.usd: 1/66.78, .rupee: 1.0, .yuan: 0.107],
        .yuan: [.usd: 1/6.87, .rupee: 9.35, .yuan: 1.0]
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Inventory")
                .font(.title)
                .padding()
            Picker("Currency", selection: $localCurrency) {
                ForEach(Currency.allCases, id: \.self) { currency in
                    Text(currency.name).tag(currency)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            List(inventory) { item in
                HStack {
                    Image(item.image)
                        .resizable()
                        .frame(width: 50, height: 50)

                    VStack(alignment: .leading) {
                        Text(item.product)
                            .font(.headline)
                        Text(item.description)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Text(
                        convertCurrency(
                            price: item.price,
                            fromCurrency: item.currency,
                            toCurrency: localCurrency
                        )
                    )
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .listStyle(PlainListStyle())
        }
    }

    private func convertCurrency(
        price: Int,
        fromCurrency: Currency,
        toCurrency: Currency
    ) -> String {

        let convertedAmount = Double(price) * currencyConversions[fromCurrency]![toCurrency]!

        return "\(toCurrency.symbol)\(String(format: "%.2f", convertedAmount))"
    }
}

struct InventoryItem: Identifiable {
    var id: Int
    var product: String
    var image: String
    var description: String
    var price: Int
    var currency: Currency

    var priceFormatted: String {
        "\(currency.symbol) \(price)"
    }
}

enum Currency: CaseIterable {
    case usd
    case rupee
    case yuan

    var name: String {
        switch self {
        case .usd:
            return "USD"
        case .rupee:
            return "Rupee"
        case .yuan:
            return "Yuan"
        }
    }

    var symbol: String {
        switch self {
        case .usd:
            return "$"
        case .rupee:
            return "₹"
        case .yuan:
            return "元"
        }
    }
}
```

This code works, but merely working is not the point of code. That's why we need to look at this with a stronger lens than just analyzing if it works and it's readable. We have to look if it's reusable. Do you notice any issues?

Think about it!

Alright, there are 3 main issues in the code above:
* The Currency Selector is coupled to the Inventory component
* The Currency Converter is coupled to the Inventory component
* The Inventory data is defined explicitly in the Inventory component and this isn't provided to the component in an API.

Every function and module should just do one thing, otherwise it can be very difficult to figure out what is going on when you look at the source code. The Inventory component should just be for displaying an inventory, not converting and selecting currencies. The benefit of making modules and functions do one thing is that they are easier to test and they are easier to reuse. If we wanted to use our Currency Converter in another part of the application, we would have to include the whole Inventory component. That doesn't make sense if we just need to convert currency.

Let's see what this looks like with more reusable components:
```swift
// Example/GoodCode/GoodCode/Reusability/ViewModels/Reusability.CurrencyConverter.swift
import SwiftUI

class CurrencyConverter: ObservableObject {
    @Published var localCurrency = Currency.usd

    private let currencyConversions: [Currency: [Currency: Double]] = [
        .usd: [.usd: 1.0, .rupee: 66.78, .yuan: 6.87],
        .rupee: [.usd: 1/66.78, .rupee: 1.0, .yuan: 0.107],
        .yuan: [.usd: 1/6.87, .rupee: 9.35, .yuan: 1.0]
    ]

    func convertCurrency(
        price: Int,
        fromCurrency: Currency
    ) -> String {
        let convertedAmount = Double(price) * currencyConversions[fromCurrency]![localCurrency]!
        return "\(localCurrency.symbol)\(String(format: "%.2f", convertedAmount))"
    }
}
```

```swift
// Example/GoodCode/GoodCode/Reusability/Views/Readability.CurrencySelector.swift

import SwiftUI

struct CurrencySelector: View {
    @Binding var selectedCurrency: Currency

    var body: some View {
        Picker("Currency", selection: $selectedCurrency) {
            ForEach(Currency.allCases, id: \.self) { currency in
                Text(currency.name).tag(currency)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }
}
```

```swift
// Example/GoodCode/GoodCode/Reusability/Views/Readability.Inventory.swift

import SwiftUI

struct Inventory: View {

    @State private var inventory: [InventoryItem]
    @ObservedObject private var currencyConverter: CurrencyConverter

    init(inventory: [InventoryItem], currencyConverter: CurrencyConverter) {
        self.inventory = inventory
        self.currencyConverter = currencyConverter
    }

    var body: some View {
        List(inventory) { item in
            HStack {
                Image(item.image)
                    .resizable()
                    .frame(width: 50, height: 50)

                VStack(alignment: .leading) {
                    Text(item.product)
                        .font(.headline)
                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Text(
                    currencyConverter.convertCurrency(
                        price: item.price,
                        fromCurrency: item.currency
                    )
                )
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
        .listStyle(PlainListStyle())
    }
}
```

```swift
// Example/GoodCode/GoodCode/Reusability/Views/Reusability.InventoryList.swift

struct InventoryList: View {

    @State private var inventory = [
        InventoryItem(
            id: 0,
            product: "Flashlight",
            image: "placeholder",
            description: "A really great flashlight",
            price: 100,
            currency: .usd
        ),
        InventoryItem(
            id: 1,
            product: "Tin can",
            image: "placeholder",
            description: "Pretty much what you would expect from a tin can",
            price: 32,
            currency: .usd
        ),
        InventoryItem(
            id: 2,
            product: "Cardboard Box",
            image: "placeholder",
            description: "It holds things",
            price: 5,
            currency: .usd
        )
    ]

    @ObservedObject private var currencyConverter = CurrencyConverter()

    var body: some View {
        VStack(alignment: .leading) {
            Title()

            CurrencySelector(selectedCurrency: $currencyConverter.localCurrency)

            Inventory(inventory: inventory, currencyConverter: currencyConverter)
        }
    }

    func Title() -> some View {
        Text("Inventory")
            .font(.title)
            .padding()
    }
}
```

This code has seen significant improvements. We now have individual modules for currency selection and conversion, and we can provide inventory data to our Inventory component without modifying its source code. This decoupling embodies the Dependency Inversion Principle, a powerful approach to creating reusable code.

However, before diving into making everything reusable, it's crucial to realize that reusability requires a well-designed API. If the API is poorly designed, future updates could harm its users. So, when should code NOT be made reusable?

- If you can't define a good API yet, avoid creating a separate module. Duplication is better than a bad foundation.
- If you don't expect to reuse your function or module in the near future.

## 3. Refactorability

Refactorable code is code you can change without fear. It's code you can deploy on a Friday night and return to on Monday morning without worrying about runtime errors affecting your users.

Refactorability is about the system as a whole, about how your reusable modules connect like LEGO pieces. If changing your `Employee` module breaks your `Reporting` module, you have refactorability issues. Refactorability is the highest level in the 3R hierarchy and the hardest to achieve and maintain. While there will always be issues in any human system, there are strategies to enhance refactorability:

- Isolated side effects
- Tests
- Static types

For large applications, I highly recommend using a statically typed alternative to Swift. Types provide extra confidence beyond what tests can offer. However, types alone aren't enough; you also need to isolate side effects and test your code.

You might wonder what it means to isolate side effects. A _side effect_ occurs when a function or module modifies data outside its own scope. Writing data to a disk, changing a global variable, or printing to the Xcode console are examples of side effects. While side effects are necessary for a program to interact with the outside world, they should be isolated.

Why should we isolate side effects?

- Side effects make code hard to test. If a function's execution modifies data that another function depends on, we can't ensure consistent output from the same input.
- Side effects introduce coupling between otherwise reusable modules. If module A modifies global state that module B depends on, A must run before B.
- Side effects make the system unpredictable. If any function or module can alter the application state, we can't be sure how changes in one module will impact the entire system.

To isolate side effects, centralize the updating of global state within the application.

Now, let's modify our existing code to incorporate a `Shopping Cart`. We'll examine this new code to understand why it is NOT refactorable:

```swift
// Example/BadCode/BadCode/Refactorability/GlobalState.swift

import Foundation

class GlobalState {
    static let shared = GlobalState()
    var cart: [InventoryItem] = []
}
```

```swift
// Example/BadCode/BadCode/Refactorability/Cart.swift

import SwiftUI

struct Cart: View {
    @State private var cart: [InventoryItem]

    private var currencyConverter: CurrencyConverter
    @State private var timer: Timer?

    init(
        currencyConverter: CurrencyConverter
    ) {
        self.cart = GlobalState.shared.cart
        self.currencyConverter = currencyConverter
    }

    var body: some View {
        VStack {
            Text("Cart")
                .font(.largeTitle)

            if cart.isEmpty {
                Text("Nothing in the cart")
            } else {
                List(cart) { item in
                    HStack {
                        Text(item.product)
                        Spacer()
                        Text(
                            currencyConverter.convertCurrency(
                                price: item.price,
                                fromCurrency: item.currency
                            )
                        )
                    }
                }
            }
        }
        .onAppear {
            startWatchingCart()
        }
        .onDisappear {
            stopWatchingCart()
        }
    }

    func startWatchingCart() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            cart = GlobalState.shared.cart
        }
    }

    func stopWatchingCart() {
        timer?.invalidate()
    }
}
```

Here we have a new shopping cart module that shows the inventory items currently in the shopping cart. There are two very problematic things in this code, what are they?

Think about it!

The main issues with the code above are:

* Global State: The `GlobalState` is a problematic practice because it makes the system fragile and difficult to debug.

* Timer for Synchronization:  The `Cart` uses a `Timer` to periodically update the local state from the global cart. This introduces a coupling to timing, which can lead to synchronization issues and unexpected behavior.

* Lack of Centralized State Management: There is no centralized place to manage the state updates, making the system unpredictable. Any part of the app can modify the global state, leading to potential conflicts and bugs.

* View Initialization: The views are initialized with local states that mirror the global state, which can become out of sync and cause inconsistencies in the UI.

This bad example showcases the issues of using global variables and timing dependencies, making the code hard to maintain and refactor. It demonstrates how these anti-patterns can lead to a brittle and unpredictable system.

Even though our modules are reusable and readable, by writing to global variables we are making our overall system very brittle. Any third-party library that we bring in could overwrite our `GlobalState.cart` with something else and break our app. Furthermore, any module we write can access it and modify it without any safeguards or centralized way of updating.

You might be saying, "Yeah, yeah I would never structure my app like this in the first place." That's great! Remember though, that even though this is exaggerated, the point is that the way the cart is updated and read is not centralized. If instead of using global variables and `Timer` you were using a message passing module, that could also make your code hard to understand and refactor at scale because it could be hard to isolate state and figure out how one module might affect another.

Let's see what this more refactorable code looks like:

```swift
// Example/GoodCode/GoodCode/Refactorability/States/Refactorability.CentralState.swift

class CentralState: ObservableObject {
    static let shared = CentralState()

    @Published var cart: [InventoryItem] = []
    @Published var inventory: [InventoryItem] = []
    @Published var localCurrency: Currency = .usd

    func addToCart(item: InventoryItem) {
        cart.append(item)
    }

    func setInventory(items: [InventoryItem]) {
        inventory = items
    }

    func setLocalCurrency(currency: Currency) {
        localCurrency = currency
    }
}
```

```swift
// Example/GoodCode/GoodCode/Refactorability/States/Refactorability.Inventory.swift

import SwiftUI

struct Inventory: View {

    @ObservedObject private var currencyConverter: CurrencyConverter
    @EnvironmentObject var centralState: CentralState

    init(currencyConverter: CurrencyConverter) {
        self.currencyConverter = currencyConverter
    }

    var body: some View {
        List(centralState.inventory) { item in
            HStack {
                Image(item.image)
                    .resizable()
                    .frame(width: 50, height: 50)

                VStack(alignment: .leading) {
                    Text(item.product)
                        .font(.headline)
                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Text(
                    currencyConverter.convert(
                        price: item.price,
                        fromCurrency: item.currency
                    )
                )
                .font(.headline)
                .foregroundColor(.blue)


                Button(action: {
                    centralState.addToCart(item: item)
                }) {
                    Text("Add")
                }
                .buttonStyle(.bordered)
            }
        }
        .listStyle(PlainListStyle())
    }
}
```

```swift
// Example/GoodCode/GoodCode/Refactorability/States/Refactorability.Cart.swift

struct Cart: View {
    @EnvironmentObject var centralState: CentralState
    private var currencyConverter = CurrencyConverter()

    var body: some View {
        VStack {
            Text("Cart")
                .font(.largeTitle)

            if centralState.cart.isEmpty {
                Text("Nothing in the cart")
            } else {
                List(centralState.cart) { item in
                    HStack {
                        Text(item.product)
                        Spacer()
                        Text(convertedPrice(for: item))
                    }
                }
            }
        }
    }

    func convertedPrice(for item: InventoryItem) -> String {
        return currencyConverter.convert(price: item.price, fromCurrency: item.currency)
    }
}
```

```swift
// Example/GoodCode/GoodCode/Refactorability/States/Refactorability.InventoryList.swift

struct InventoryList: View {

    @EnvironmentObject var centralState: CentralState
    @ObservedObject private var currencyConverter = CurrencyConverter()

    var body: some View {
        VStack {
            Title()

            Refactorability.Inventory(currencyConverter: currencyConverter)

            Spacer()

            NextButton()
        }
    }

    func Title() -> some View {
        Text("Inventory")
            .font(.title)
            .padding()
    }

    func NextButton() -> some View {
        Section {
            Text("Total in cart \(centralState.cart.count)")
                .font(.headline)
                .padding()
        }
    }
}
```

```swift
struct refactorabilityReusableGoodPreview: PreviewProvider {
    static var previews: some View {
        Refactorability.InventoryList()
            .environmentObject(Refactorability.CentralState.mock)
    }
}
```

This improved code centralizes our side effects to a method within the `CentralState` class, which takes an `InventoryItem` and adds it to the cart. The cart is managed as a `@Published` property within `CentralState`, ensuring that all components that depend on the cart's state are automatically notified and updated when the state changes. SwiftUI intelligently re-renders each updated view, maintaining a clear and predictable state flow.

This approach ensures that the state of the application can only be updated in one way, through the `CentralState` class. There's no need for global state modifications, no messages to pass, and no uncontrolled side effects that our modules can produce. The best part is, we can keep track of the entire state of our application, making debugging and QA much easier because we have an exact snapshot in time of our entire application.

One caveat to note: you might not need a complex state management solution in this project's example application. However, as the codebase grows, it would become more manageable to use a state management solution like the `CentralState` class instead of putting everything in top-level controllers. By isolating the state management in `CentralState` early on, we ensure that our application remains scalable and maintainable without requiring significant changes as it develops.

Explanation:

* Centralized State Management: `CentralState` class acts as a single source of truth for the application's state. It uses `@Published` properties to automatically notify views of state changes.

* Environment Object: By using `@EnvironmentObject`, we inject the central state into views that need access to the shared state, ensuring that state updates are managed centrally and propagated automatically.

* Simplified Conversion Logic: The `CurrencyConverter` class provides a method to convert prices based on currencies, similar to the provided currency converter in the JavaScript code.

* Structuring Views: `Inventory` and `Cart` are designed to work with the central state, accessing and modifying it via the `EnvironmentObject` pattern.

This structure makes it easier to manage state changes, ensures a clear flow of data, and reduces the potential for side effects and bugs. The state updates follow a predictable pattern, making the code easier to maintain and debug.

### Tests

The last thing we need to look at is tests. Tests give us confidence that we can change a module and it will still do what it was intended to do. We will look at the tests for the CentralState and CurrencyConverter:

```swift
// Example/GoodCode/Tests/CentralState.Tests.swift

import XCTest
@testable import GoodCode

class CentralStateTests: XCTestCase {
    let centralState = Refactorability.CentralState.mock

    func testAddToCart() {
        let item = Readability.InventoryItem(
            id: 0,
            product: "Flashlight",
            image: "placeholder",
            description: "A really great flashlight",
            price: 100,
            currency: .usd
        )

        centralState.addToCart(item: item)
        XCTAssertEqual(centralState.cart.count, 1)
        XCTAssertEqual(centralState.cart.first, item)
    }

    func testSetInventory() {
        let items = [
            Readability.InventoryItem(
                id: 0,
                product: "Flashlight",
                image: "placeholder",
                description: "A really great flashlight",
                price: 100,
                currency: .usd
            ),
            Readability.InventoryItem(
                id: 1,
                product: "Tin can",
                image: "placeholder",
                description: "Pretty much what you would expect from a tin can",
                price: 32,
                currency: .usd
            ),
            Readability.InventoryItem(
                id: 2,
                product: "Cardboard Box",
                image: "placeholder",
                description: "It holds things",
                price: 5,
                currency: .usd
            )
        ]
        centralState.setInventory(items: items)
        XCTAssertEqual(centralState.inventory, items)
    }

    func testSetLocalCurrency() {
        let currency = Readability.Currency.usd
        centralState.setLocalCurrency(currency: currency)
        XCTAssertEqual(centralState.localCurrency, currency)
    }
}

extension Readability.InventoryItem: Equatable {
    public static func == (lhs: Readability.InventoryItem, rhs: Readability.InventoryItem) -> Bool {
        lhs.id == rhs.id
    }
}
```

```swift
// Example/GoodCode/Tests/CurrencyConverter.Tests.swift

import XCTest
@testable import GoodCode

class CurrencyConverterTests: XCTestCase {
    func testConvert() {
        let converter = Reusability.CurrencyConverter()
        converter.localCurrency = .usd

        // Test conversion from USD to Rupee
        let usdToRupee = converter.convert(price: 100, fromCurrency: .usd)
        XCTAssertEqual(usdToRupee, "$100.00")

        // Test conversion from Rupee to Yuan
        let rupeeToYuan = converter.convert(price: 500, fromCurrency: .rupee)
        XCTAssertEqual(rupeeToYuan, "$7.49")

        // Test conversion from Yuan to USD
        let yuanToUsd = converter.convert(price: 1000, fromCurrency: .yuan)
        XCTAssertEqual(yuanToUsd, "$145.56")
    }
}
```

These tests ensure that the the CentralState and CurrencyConverter:

* Verifies that adding an item to the cart works correctly by checking if the cart contains the correct item and the count of items is as expected.

* Ensures the inventory is set correctly by comparing the current inventory state with the expected list of items.
*: Confirms that setting the local currency updates the state properly by checking if the local currency state matches the expected currency.

* Checks the conversion logic for different currency pairs to ensure accuracy. It tests conversion from USD to Rupee, Rupee to Yuan, and Yuan to USD to verify the correctness of the conversion values.

## Final Thoughts

Software architecture is the stuff that's hard to change, so invest early in a readable, reusable, and refactorable foundation. It will be hard to get there later on. By following the 3 Rs, your users will thank you, your developers will thank you, and you will thank yourself.

---

## Contributing

Thank you for your contributions!

Before opening a friendly Pull Request, make sure you run the following and resolve any errors noted by the linter.

Finally, change any relevant code examples in this `README.md` to reflect your changes.

## License
[MIT](LICENCE)
