//
//  CustomProgressView.swift
//  MovieApp
//
//  Created by Jose Caraballo on 15/10/22.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .green))
            .padding(5)
            .background(
                Color.gray.opacity(0.2)
            )
            .cornerRadius(10)
            .scaleEffect(3)
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
