//
//  UIKitView.swift
//  MovieApp
//
//  Created by Jose Caraballo on 15/10/22.
//

import UIKit
import SwiftUI

struct SearchField: UIViewRepresentable {
    @Binding var text: String

    private var placeholder = ""

    init(text: Binding<String>) {
        _text = text
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = placeholder
        return searchBar
    }

    // Always copy the placeholder text across on update
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
        uiView.placeholder = placeholder
    }
}

struct CustomButton: UIViewRepresentable {
    var title: String
    
    func makeUIView(context: Context) -> UIButton {
        let bt = UIButton()
        bt.setTitle(title, for: .normal)
        bt.backgroundColor = .systemGreen

        return bt
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        uiView.setTitle(title, for: .normal)
    }
}
