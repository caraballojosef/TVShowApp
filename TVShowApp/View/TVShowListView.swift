//
//  TVShowListView.swift
//  MovieApp
//
//  Created by Jose Caraballo on 14/10/22.
//

import SwiftUI

struct TVShowListView: View {
    
    //MARK: - Properies
    @EnvironmentObject var vm: TVShowViewModel
    @State var nav: Bool = false
    @State var showID : Int = 0
    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: threeColumnGrid, spacing: 5) {
                ForEach(vm.shows, id: \.id) { m in
                        Button {
                            Task {
                                vm.getMovie(id: m.id)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                    nav = vm.nav
                                    vm.isRefreshing = false
                                }
                            }
                        } label: {
                            TVShowView(movie: m)
                                .frame(height: 440)
                       }
                } //: Foreach
            } //: VGrid
        } //: Scroll
        .fullScreenCover(isPresented: $nav) {
            TVShowDetailView()
        }
        .alert(isPresented: $vm.isError) {
            Alert(title: Text("Error"), message: Text("\(vm.alertMsg)"), dismissButton: .cancel(Text("Ok")))
        }
                
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowListView()
    }
}
