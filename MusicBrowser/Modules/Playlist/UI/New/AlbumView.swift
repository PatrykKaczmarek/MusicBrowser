//
// AlbumView.swift
// MusicBrowser
//
        
import SwiftUI

struct AlbumView: View {
    @ObservedObject var album: StorableAlbum
    var onFavoriteChange: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading) {
            RectangleImage(imageURL: album.coverURLString)
                .padding(.top, 32)
            HStack(alignment: .center) {
                Spacer()
                Text(album.title)
                    .font(.title)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .navigationTitle("screen.album.navigation.title".localized())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                FavoriteButton(isSet: Binding(
                    get: {
                        album.isFavorite
                    }, set: { newValue, _ in
                        album.isFavorite = newValue
                        onFavoriteChange?()
                    }
                ))
            }
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(
            album: StorableAlbum(
                identifier: "1",
                title: "fixture.titile",
                coverURLString: ""
            )
        )
    }
}
