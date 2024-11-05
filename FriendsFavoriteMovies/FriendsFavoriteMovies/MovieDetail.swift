//
//  MovieDetail.swift
//  FriendsFavoriteMovies
//
//  Created by arata.haruyama on 2024/11/05.
//

import SwiftUI

struct MovieDetail: View {
    @Bindable var movie: Movie

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Form {
            TextField("Movie title", text: $movie.title)
                .autocorrectionDisabled()
            DatePicker("Release date", selection: $movie.releaseDate, displayedComponents: .date)
        }
        .navigationTitle("Movie")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MovieDetail(movie: SampleData.shared.movie)
    }
}
