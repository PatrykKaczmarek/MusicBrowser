//
// RectangleImage.swift
// MusicBrowser
//
        
import SwiftUI

struct RectangleImage: View {
    var imageURL: String

    var body: some View {
        GeometryReader { reader in
            HStack(alignment: .center) {
                Spacer()

                AsyncImage(url: URL(string: imageURL)) { phase in
                    ZStack {
                        if let image = phase.image {
                            image
                        } else {
                            Color(.gray).opacity(0.6)

                            Image(systemName: "photo.artframe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(EdgeInsets(top: 48, leading: 48, bottom: 48, trailing: 48))
                                .foregroundColor(.white)
                        }
                    }
                    .clipShape(Rectangle())
                    .overlay {
                        Rectangle().stroke(.white, lineWidth: 4)
                    }
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 7)
                    .frame(width: reader.size.width * 0.7, height: reader.size.width * 0.7)
                }
                .frame(width: reader.size.width * 0.7, alignment: .center)
                Spacer()
            }
        }
    }
}

struct RectangleImage_Previews: PreviewProvider {
    static var previews: some View {
        RectangleImage(imageURL: "")
    }
}
