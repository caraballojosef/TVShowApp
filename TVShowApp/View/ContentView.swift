//
//  ContentView.swift
//  MovieApp
//
//  Created by Jose Caraballo on 11/10/22.
//

import SwiftUI

enum MenuSegmented: String, CaseIterable {
    case popular = "Popular"
    case top_rated = "Top Rated"
    case upcoming = "Upcoming"
    case now_playing = "Airing Today"
}

struct ContentView: View {
    
    //MARK: - Properties
    
    @EnvironmentObject var vm: TVShowViewModel
    @State private var menuSelected : MenuSegmented = .popular
    @State var textField = ""
    //MARK: - Body
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Picker("", selection: $menuSelected) {
                    ForEach(MenuSegmented.allCases, id: \.self) {
                        Text($0.rawValue)
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.top, .horizontal], 8)
                SearchField(text: $textField)
                TVShowListView()
                Spacer()
            }//: VStack
            .blur(radius: vm.isRefreshing ? 5 : 0)
            .animation(.easeIn(duration: 1), value: vm.isRefreshing)
            .navigationTitle("TVShow App!")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        //Action
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.white)
                    }
                }
            }) //: Toolbar
            .overlay {
                    if vm.isRefreshing {
                        CustomProgressView()
                    }
            }
            .onAppear(){
                if vm.shows.isEmpty {
                    vm.getMovieList(from: .popular)
                }
            }
            .onChange(of: menuSelected) { newValue in
                switch newValue {
                case .popular:
                    vm.getMovieList(from: .popular)
                case .top_rated:
                    vm.getMovieList(from: .topRated)
                case .upcoming:
                    vm.getMovieList(from: .upcoming)
                case .now_playing:
                    vm.getMovieList(from: .airingToday)
                }
            }
            
        } //: Nav
    }
}
    //MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(textField: "")
    }
}
