//
//  CheckOutView.swift
//  iDine
//
//  Created by Daffolapmac-155 on 22/11/22.
//

import SwiftUI

struct CheckOutView: View {
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumbers = ""
    @State private var tipAmount = 15
    @State private var showingPaymentAlert = false
    @State private var selectedDeliveryTime = "Now"
    let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    let deliveryTime = ["Now","Tonight","Tomorrow"]
    let tipAmounts = [10,15,20,25,0]
    var totalPrice: String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let total = Double(order.total)
        let tipValue = total/100 * Double(tipAmount)
        return formatter.string(from: NSNumber(value: total + tipValue)) ?? "$0"
        
    }
    var body: some View {
        Form{
            Section{
                Picker("How do u want to pay?", selection: $paymentType) {
                    ForEach(paymentTypes,id: \.self){
                        Text($0)
                    }
                }
                Toggle("Add iDine loyalty card", isOn: $addLoyaltyDetails.animation())
                if addLoyaltyDetails{
                    TextField("Enter your iDine ID", text: $loyaltyNumbers)
                }
            }
            
            Section {
                Picker("Percentage", selection: $tipAmount) {
                    ForEach(tipAmounts, id: \.self){
                        Text("\($0)%")
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Add a tip?")
            }
            
            
            Section{
                Picker("Time", selection:$selectedDeliveryTime) {
                    ForEach(deliveryTime, id: \.self){
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }  header: {
                Text("Pickup Time")
            }
            
            Section {
                Button("Confirm order") {
                    showingPaymentAlert.toggle()
                }
                
            } header: {
                Text("TOTAL: \(totalPrice)")
                    .font(.largeTitle)
            }

        }
        .alert(isPresented: $showingPaymentAlert, content: {
            Alert(title: Text("Order confirmed"), message: Text("Your total was \(totalPrice).\n Thank you!"), dismissButton: .default(Text("OK")))
        })
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
            CheckOutView()
                .environmentObject(Order())
    }
}
