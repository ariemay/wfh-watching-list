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
                    .fontWeight(.bold)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(results) { res in
                            VStack {
                                NavigationLink(destination: MovieDetails(data: res)) {
                                    ImageViewWidget(url: Configurations.API_URL_IMAGE + res.poster_path)
                                }
                                .buttonStyle(PlainButtonStyle())
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
        let json = Configurations.API_TOP_RATE_MOVIES
        
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


