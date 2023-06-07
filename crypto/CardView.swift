//
//  CardView.swift
//  crypto
//
//  Created by Pavel Sizonenko on 07.06.23.
//

import Foundation
import SwiftUI

struct CardView: View {
    var name: String
    var price: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.white)
            Text("Price: \(price)")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding() // Padding around the text
        .frame(maxWidth: .infinity) // Makes the card expand to take up all available width
        .background(
            LinearGradient(gradient: Gradient(colors: [.black, .orange]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(15) // Rounded rectangle as background
        .shadow(color: .gray, radius: 10, x: 0, y: 10) // Adds shadow around the card
        .padding(.horizontal) // Horizontal padding around the card
        .padding(.vertical, 5)
    }
}
