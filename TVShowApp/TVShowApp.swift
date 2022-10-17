//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Jose Caraballo on 11/10/22.
//

import SwiftUI

@main
struct TVShowApp: App {
    //MARK: - Properties
    @StateObject var postViewModel = TVShowViewModel(service: ServiceImplementation())
    ///Customize NavBar
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        //coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(red: 31.0 / 255.0, green: 41.0 / 255.0, blue: 45.0 / 255.0, alpha: 0.85)
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
          //UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(postViewModel)
                .preferredColorScheme(.dark)
                
        }
    }
}

