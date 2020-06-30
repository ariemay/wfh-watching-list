//
//  Movies.swift
//  wfh-movie-todo
//
//  Created by Arie May Wibowo on 30/06/20.
//

import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title, poster_path, overview: String
}

struct MovieRequest: Decodable {
    let results: [Movie]
}


let testData = Movie(id: 1, title: "Avenger", poster_path: "test", overview: "test")

