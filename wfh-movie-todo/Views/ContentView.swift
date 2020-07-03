//
//  ContentView.swift
//  wfh-movie-todo
//
//  Created by Arie May Wibowo on 30/06/20.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ContentView: View {
    
    @ObservedObject var networkManager: NetworkManager = NetworkManager()
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .black
        coloredAppearance.titleTextAttributes = [
            .font : UIFont(name: "HelveticaNeue-Thin", size: 20)!]
        coloredAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font : UIFont(name:"Papyrus", size: 40)!]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView(.vertical, showsIndicators: false) {
                    Text("Top Movie List")
                        .font(.title3)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(networkManager.topMovies) { res in
                                VStack {
                                    MovieList(data: res)
                                }
                            }
                        }.onAppear {
                            self.networkManager.loadTopMovies()
                        }
                    }
                    Text("Now Playing Movie")
                        .font(.title3)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(networkManager.nowPlayingMovies) {
                                res in
                                VStack {
                                    MovieList(data: res)
                                }
                            }
                        }.onAppear {
                            self.networkManager.loadNowPlayingMovies()
                        }
                    }
                    Spacer()
                }
                .navigationBarTitle("WFH Watching List")
                .padding()
            }
        }
    }
    
}



struct MovieList: View {
    @State var data: Movie
    
    var body: some View {
        NavigationLink(destination: MovieDetails(data: data)) {
            ImageViewWidget(url: Configurations.API_URL_IMAGE + data.poster_path)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
