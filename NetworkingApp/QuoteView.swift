//
//  QuoteView.swift
//  NetworkingApp
//
//  Created by Chad Eymard on 4/15/24.
//

import SwiftUI

struct QuoteView: View {
    // MARK: - PROPERTIES
    @StateObject private var viewModel: ViewModel = ViewModel(controller: FetchController())
    let show: String
    @State private var isCharacterViewShowing: Bool = false
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowercasedNoSpaces)
                    .resizable()
                    .scaledToFill()
                VStack {
                    VStack {
                        Spacer()
                        switch viewModel.status {
                        case .success(let data):
                            Text("\"\(data.quote.quote)\"")
                                .minimumScaleFactor(0.50)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .cornerRadius(25)
                                .padding(.horizontal)
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: data.charater.images[0]) {
                                    image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                                .onTapGesture {
                                    isCharacterViewShowing.toggle()
                                }
                                .sheet(isPresented: $isCharacterViewShowing, content: {
                                    CharacterView(show: show, character: data.charater)
                                })
                                
                                Text(data.quote.character)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            } //: ZSTACK
                            .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                            .cornerRadius(80)
                            .padding(.bottom, 15)
                            
                        case .fetching:
                            ProgressView()
                        default:
                            EmptyView()
                        }
                        Spacer()
                    } //: VSTACK
                    Button {
                        Task {
                            await viewModel.getData(for:  show)
                        }
                    } label: {
                        Text("Get random quotes")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("\(show.noSpaces)Button"))
                            .cornerRadius(7)
                            .shadow(color: Color("\(show.noSpaces)Shadow"), radius: 2)
                    }
                    Spacer(minLength: 100)
                } //: VSTACK
                .frame(width: geo.size.width)
            } //: ZSTACK
            .frame(width: geo.size.width, height: geo.size.height)
        }  //: GEOMETRY READER
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEW
struct QuoteView_Preview: PreviewProvider {
    static var previews: some View {
        QuoteView(show: Constants.bbName)
            .preferredColorScheme(.dark)
    }
}
