//
//  CharacterView.swift
//  NetworkingApp
//
//  Created by Chad Eymard on 4/16/24.
//

import SwiftUI

struct CharacterView: View {
    // MARK: - PROPERTIES
    let show: String
    let character: Character
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .top) {
                // background image
                Image(show.lowercasedNoSpaces)
                    .resizable()
                    .scaledToFit()
                ScrollView {
                    // character image
                    VStack {
                        AsyncImage(url: character.images.randomElement()) {
                            image in
                            
                            image
                                .resizable()
                                .scaledToFill()
                                
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                    .cornerRadius(25)
                    .padding(.top, geo.size.height / 15)
                    
                    // character info
                    VStack (alignment: .leading) {
                        Text(character.name)
                            .font(.largeTitle)
                        
                        Text("Portrayed By: \(character.portrayedBy)")
                            .font(.subheadline)
                        
                        Divider()
                        
                        Text("\(character.name) Character Info")
                           .font(.title2)
                        
                        Text("Born: \(character.birthday)")
                        
                        Divider()
                        
                        Text("Occupations:")
                        
                        ForEach(character.occupations, id: \.self) { occupation in
                            Text("∙ \(occupation)")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        
                        
                        if character.aliases.count > 0 {
                            Text("Aliases:")
                            ForEach(character.aliases, id: \.self) { alias in
                                    Text("∙ \(alias)")
                                    .font(.subheadline)
                            }
                        } else {
                            EmptyView()
                        }
                    }
                    .padding([.bottom, .leading], 40)
                    
                } //: SCROLLVIEW
                
            } //: ZSTACK
        } //: GEOMETRY READER
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEW
struct CharacterView_Preview: PreviewProvider {
    static var previews: some View {
        CharacterView(show: Constants.bbName, character: Constants.previewCharacter)
            .preferredColorScheme(.dark)
    }
}
