import SwiftUI

struct CheckOutView: View {
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    let paymenTypes = ["Cash", "Credit Card", "iDine Points"]
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 15
    @State private var showPaymentAlert = false
    let tipAmounts = [10, 15, 20, 25, 0]
    var totalPrice: String {
        let total = Double(order.total)
        let tipValue = Double(tipAmount) * total / 100
        return (total + tipValue).formatted(.currency(code: "USD"))
    }
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(paymenTypes, id: \.self) {
                        Text($0)
                    }
                }
                Toggle("Add iDine loyalty card", isOn: $addLoyaltyDetails.animation())
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            Section("Add a tip?") {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(tipAmounts, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section("Total: \(totalPrice)") {
                Button("Confirm Order") {
                    showPaymentAlert.toggle()
                }
            }
        }
        .navigationTitle("Payment")
        .alert("Order confirmed", isPresented: $showPaymentAlert) {
            
        } message: {
            Text("Your total was \(totalPrice) - thank you!")
        }
    }
}

#Preview {
    CheckOutView()
        .environmentObject(Order())
}
