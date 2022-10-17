//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Jose Caraballo on 12/10/22.
//

import Foundation
import Combine
import SwiftUI

class TVShowViewModel: ObservableObject {
    
    //MARK: - Properties
    private let service: Service
    private var cancellables = Set<AnyCancellable>()
    @Published var showAlert = false
    @Published var alertMsg = ""
    @Published var isRefreshing = false
    @Published var isError = false
    @Published var shows = [Result]()
    @Published var show: TVShow?
    @Published var nav = false
    
    init(service: Service) {
        self.service = service
    }
    
    //MARK: - Functions
    
    ///Get movie detail

    func getMovie(id: Int) {
        isRefreshing = true
     
        let cancellable = service
            .requestNew(from: .getMovie(id: id), type: TVShow.self)
            .sink { res in
                switch res {

                case .finished:
                  break
                case .failure(let error):
                    self.isError = true
                    if error.localizedDescription == APIError.decodingError.localizedDescription {
                        self.alertMsg = "There is an error in this response!"
                    }
                    print(error.localizedDescription)
                    self.isRefreshing = false
                    self.nav = false
                }
            } receiveValue: { response in
                print("This the detail movie: \(response)")
                self.show = response
                //self.isRefreshing = false
                self.isError = false
                self.nav = true
            }
        self.cancellables.insert(cancellable)
       
    }  
    
    /// Get a specific movie list
    
    func getMovieList(from endpoint: MovieListEndpoint) {
        isRefreshing = true
     
        let cancellable = service
            .requestNew(from: .getMovieList(endpoint: endpoint), type: Shows.self)
            .sink { res in
                switch res {

                case .finished:
                  break
                case .failure(let error):
                    self.isError = true
                    self.alertMsg = error.localizedDescription
                    //print(error.localizedDescription)
                    //print(endpoint)
                    self.isRefreshing = false
                    self.shows = []
                }
            } receiveValue: { response in
                self.shows = response.results
                //print(self.shows[0])
                self.isRefreshing = false
            }
        self.cancellables.insert(cancellable)
    }
    
    func getLastSeason() -> Int {
        if show?.seasons.count == 1 {
            return 0
        } else {
            let max = show?.seasons.max(by: { s1, s2 in
                s1.seasonNumber < s2.seasonNumber
            })
            return max!.seasonNumber
        }
    }
    
}
