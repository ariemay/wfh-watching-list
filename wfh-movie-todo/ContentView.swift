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
    
    @State private var results = [Movie]()
    var baseurlImage: String = "https://image.tmdb.org/t/p/w185"
    
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
                Text("Top Movie List")
                    .font(.title3)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(results) { res in
                            VStack {
                            ImageViewWidget(url: baseurlImage + res.poster_path)
                            }
                        }
                    }.onAppear {
                        loadData()
                    }
                }
                Spacer()
            }
            .navigationBarTitle("WFH Watching List")
            .padding()
        }
    }
    
    func loadData() {
        let json = "https://api.themoviedb.org/3/movie/top_rated?api_key=3d6b6b6c1ceb0ab7ccfbc54cb997b1a2"
        
        guard let url = URL(string: json) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            let movieRequest = try! JSONDecoder().decode(MovieRequest.self, from: data)
            
            DispatchQueue.main.async {
                results = movieRequest.results
            }
        }.resume()
    }
    
}


