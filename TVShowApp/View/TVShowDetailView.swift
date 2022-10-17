//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Jose Caraballo on 14/10/22.
//

import SwiftUI

struct TVShowDetailView: View {
    
    //MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm : TVShowViewModel
    @ObservedObject var il = ImageLoader()
    
    //MARK: - Body
    
    var body: some View {
                VStack {
                    if self.vm.show == nil {
                        CustomProgressView()
                    } else {
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.05))
                                .cornerRadius(8)
                                .frame(height: 200)
                            if self.il.image != nil {
                                Image(uiImage: self.il.image!)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(8)
                                    .shadow(radius: 4)
                            } else {
                                ProgressView()
                            }
                        } //:ZStack
                        
                        ScrollView {
                            VStack (alignment: .leading, spacing: 15) {
                                HStack {
                                    Text(vm.show!.name)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    Spacer()
                                    Image(systemName: "heart")
                                        .foregroundColor(.green)
                                        .fontWeight(.black)
                                        .frame(width: 20, height: 20)
                                }
                                
                                Text(vm.show!.overview)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                
                                HStack {
                                    Text("Created by")
                                        .font(.system(.caption2))
                                        .fontWeight(.semibold)
                                    ForEach(vm.show!.createdBy, id: \.id) { c in
                                        Text(c.name)
                                            .font(.system(.caption2))
                                            .fontWeight(.semibold)
                                    }
                                }
                                
                                HStack(alignment: .center, spacing: 10) {
                                    VStack {
                                        Text("Last Season")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.green)
                                        
                                        AsyncImage(url: URL(string: "\(baseUrlImage)/\(vm.show!.seasons[vm.getLastSeason()].posterPath)")) { im in
                                            if let image = im.image {
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .cornerRadius(8)
                                                    .shadow(radius: 4)
                                            } else if im.error != nil {
                                                Text("Error loading image")
                                            } else {
                                                ProgressView()
                                            }
                                        }
                                        .frame(height: 180)
                                        
                                    }
                                    Spacer()
                                    VStack (spacing: 10) {
                                        Spacer()
                                        Text("Season \(vm.show!.lastEpisodeToAir.seasonNumber)")
                                            .font(.system(.caption2))
                                            .fontWeight(.semibold)
                                        
                                        Text("Season \(vm.show!.lastEpisodeToAir.airDate)")
                                            .font(.system(.caption2))
                                            .fontWeight(.semibold)
                                        
                                        CustomButton(title: "View all seasons")
                                            .fontWeight(.bold)
                                            .cornerRadius(10)
                                            .frame(height: 40)
                                            .padding(10)
                                        Spacer()
                                    }
                                } //:HStack
                                
                                Text("Cast")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                                
                                Text(vm.show!.tagline)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            } //: VStack
                        } //Scroll
                        .padding(.horizontal, 40)
                        .padding(.top, 30)
                        .background(
                            Rectangle()
                                .fill()
                                .foregroundColor(
                                    Color(red: 37/255, green: 39/255, blue: 47/255)
                                )
                                .cornerRadius(10)
                                .padding(.horizontal, 25)
                                .overlay(content: {
                                    ZStack {
                                        Circle()
                                            .foregroundColor(.green)
                                            .frame(width: 30, height: 30)
                                        Text("\(vm.show!.voteAverage)".prefix(3))
                                    }
                                    .offset(x: 120, y: -270)
                                })
                            
                        )
                        .offset(y: -50)
                    }//: Else
                }
            .onAppear(){
                Task {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.il.loadImage(with: vm.show!.postURL)
                    }
                }
            }
            .overlay {
                    VStack {
                        HStack {
                            Button {
                                withAnimation {
                                    dismiss()
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .font(.title)
                                        .foregroundColor(.white)
                                    Text("Movie App!")
                                        .foregroundColor(.white)
                                }
                                
                            }
                            .buttonStyle(.plain)
                            Spacer()
                        } //: HStack
                        Spacer()
                    }
            }//Overlay
    }
}

struct TVShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowDetailView()
    }
}
