//
//  TVShowView.swift
//  MovieApp
//
//  Created by Jose Caraballo on 12/10/22.
//

import SwiftUI

struct TVShowView: View {
    //MARK: - Properties
    let movie: Result
    @ObservedObject var imageLoader = ImageLoader()
    
    //MARK: - Body
    var body: some View {
                
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.05))
                            .cornerRadius(8)
                            .frame(height: 290)
                        if self.imageLoader.image != nil {
                            Image(uiImage: self.imageLoader.image!)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(8)
                                .shadow(radius: 4)
                        }
                        
                    } //: ZStack
                    .overlay() {
                        if imageLoader.isLoading {
                            ProgressView()
                        }
                    }
                    VStack {
                        Text(movie.name)
                            .font(.system(size: 14, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                            .lineLimit(2)
                            
                        HStack {
                            Text("\(movie.firstAirDate)")
                                .font(.system(.caption, design: .rounded))
                                .modifier(TextModifier())
                                .foregroundColor(.green)
                            Spacer()
                            HStack(spacing: 3) {
                                Image(systemName: "star.fill")
                                    .font(.caption)
                                    .foregroundColor(.green)
                                Text("\(movie.voteAverage)".prefix(3))
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }
                        } //:HStack
                        Text("Language: \(movie.originalLanguage)")
                            .font(.system(.footnote))
                            .modifier(TextModifier())
                            .foregroundColor(.green)
                        
                        Text(movie.overview)
                            .font(.caption)
                            .foregroundColor(.white)
                            .lineLimit(5)
                            .multilineTextAlignment(.leading)
                            
                    } //: VStack
                    .padding([.bottom, .horizontal], 8)
                    .frame(height: 140)
                }
            .background(
                Color(red: 10.0 / 255.0, green: 21.0 / 255.0, blue: 27.0 / 255.0)
                    .cornerRadius(20)
            )
            .onAppear() {
                //withAnimation(.easeOut(duration: 1.2)) {
                    self.imageLoader.loadImage(with: self.movie.postURL)
                //}
                
            }
    }
}

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.scaledToFit()
            .minimumScaleFactor(0.4)
            .lineLimit(2)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowView(movie: movies[0])
            .background(
                Color.blue
            )
    }
}
