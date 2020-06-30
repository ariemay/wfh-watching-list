//
//  MovieDetails.swift
//  wfh-movie-todo
//
//  Created by Arie May Wibowo on 30/06/20.
//

import SwiftUI

struct MovieDetails: View {
    
    var data: Movie
    
    var body: some View {
        Text(data.title)
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(data: testData)
    }
}
